// OCR Processor for Count Sheets
// Processes scanned count sheets to extract typed text and handwritten numbers

import Tesseract from 'tesseract.js'

export interface OCRCountResult {
  sku: string
  productName?: string
  countedQuantity: number | null
  notes?: string
  confidence: number
  rawValue: string
}

export interface OCRProcessingResult {
  success: boolean
  countId?: string
  items: OCRCountResult[]
  totalProcessed: number
  highConfidenceCount: number
  lowConfidenceCount: number
  errors: string[]
  processingTime: number
}

export interface OCRProgress {
  status: string
  progress: number
}

// Process a scanned count sheet image
export async function processCountSheetImage(
  imageFile: File | Blob | string,
  onProgress?: (progress: OCRProgress) => void
): Promise<OCRProcessingResult> {
  const startTime = Date.now()
  const errors: string[] = []
  const items: OCRCountResult[] = []

  try {
    onProgress?.({ status: 'Initializing OCR engine...', progress: 0 })

    // Create Tesseract worker with optimized settings for mixed content
    const worker = await Tesseract.createWorker('eng', 1, {
      logger: (m) => {
        if (m.status === 'recognizing text') {
          onProgress?.({
            status: 'Scanning document...',
            progress: Math.round(m.progress * 70) + 10
          })
        }
      }
    })

    onProgress?.({ status: 'Processing image...', progress: 10 })

    // Set parameters for better handwriting recognition
    await worker.setParameters({
      tessedit_char_whitelist: '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_. ',
      preserve_interword_spaces: '1',
      tessedit_pageseg_mode: Tesseract.PSM.SPARSE_TEXT_OSD
    })

    // Recognize text
    const result = await worker.recognize(imageFile)

    onProgress?.({ status: 'Extracting data...', progress: 80 })

    // Parse the OCR result
    const parsedItems = parseOCRText(result.data.text, result.data.confidence)

    items.push(...parsedItems)

    // Try to extract count ID from the document
    const countIdMatch = result.data.text.match(/ID:\s*([A-Z0-9]{8})/i)
    const countId = countIdMatch ? countIdMatch[1] : undefined

    await worker.terminate()

    onProgress?.({ status: 'Complete', progress: 100 })

    const highConfidenceCount = items.filter(i => i.confidence >= 80).length
    const lowConfidenceCount = items.filter(i => i.confidence < 80 && i.confidence > 0).length

    return {
      success: true,
      countId,
      items,
      totalProcessed: items.length,
      highConfidenceCount,
      lowConfidenceCount,
      errors,
      processingTime: Date.now() - startTime
    }
  } catch (error) {
    errors.push(error instanceof Error ? error.message : 'Unknown OCR error')
    return {
      success: false,
      items: [],
      totalProcessed: 0,
      highConfidenceCount: 0,
      lowConfidenceCount: 0,
      errors,
      processingTime: Date.now() - startTime
    }
  }
}

// Parse OCR text to extract count data
function parseOCRText(text: string, overallConfidence: number): OCRCountResult[] {
  const items: OCRCountResult[] = []
  const lines = text.split('\n').filter(line => line.trim())

  // Pattern to match SKU, possibly name, and a number
  // SKUs typically follow patterns like: ABC-123, ABC123, 123-ABC
  const skuPattern = /([A-Z]{2,4}[-]?\d{3,6}|\d{3,6}[-]?[A-Z]{2,4})/gi

  for (const line of lines) {
    const skuMatches = line.match(skuPattern)
    if (!skuMatches) continue

    for (const sku of skuMatches) {
      // Look for numbers after the SKU (the count)
      const afterSku = line.substring(line.indexOf(sku) + sku.length)
      const numberMatch = afterSku.match(/\b(\d+(?:\.\d+)?)\b/)

      if (numberMatch) {
        // Calculate confidence based on character clarity
        const confidence = calculateItemConfidence(line, numberMatch[1], overallConfidence)

        items.push({
          sku: sku.toUpperCase(),
          countedQuantity: parseFloat(numberMatch[1]),
          confidence,
          rawValue: numberMatch[1]
        })
      }
    }
  }

  return items
}

// Calculate confidence for a specific item based on OCR quality indicators
function calculateItemConfidence(
  line: string,
  value: string,
  overallConfidence: number
): number {
  let confidence = overallConfidence

  // Reduce confidence for ambiguous characters
  const ambiguousChars = ['0', 'O', 'o', '1', 'l', 'I', '5', 'S', '8', 'B']
  const valueChars = value.split('')

  for (const char of valueChars) {
    if (ambiguousChars.includes(char)) {
      confidence -= 5
    }
  }

  // Boost confidence for clean numeric values
  if (/^\d+$/.test(value)) {
    confidence += 10
  }

  // Cap confidence between 0 and 100
  return Math.max(0, Math.min(100, confidence))
}

// Alternative: Process using table structure detection
export async function processCountSheetWithTableDetection(
  imageFile: File | Blob | string,
  expectedProducts: { sku: string; name: string }[],
  onProgress?: (progress: OCRProgress) => void
): Promise<OCRProcessingResult> {
  const startTime = Date.now()
  const errors: string[] = []
  const items: OCRCountResult[] = []

  try {
    onProgress?.({ status: 'Initializing enhanced OCR...', progress: 0 })

    const worker = await Tesseract.createWorker('eng')

    // Use table-optimized page segmentation
    await worker.setParameters({
      tessedit_char_whitelist: '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_. ',
      preserve_interword_spaces: '1',
      tessedit_pageseg_mode: Tesseract.PSM.SINGLE_BLOCK
    })

    onProgress?.({ status: 'Scanning document...', progress: 20 })

    const result = await worker.recognize(imageFile)

    onProgress?.({ status: 'Matching products...', progress: 70 })

    // Match OCR results with expected products
    const text = result.data.text.toUpperCase()
    const lines = text.split('\n')

    for (const product of expectedProducts) {
      const skuUpper = product.sku.toUpperCase()

      // Find the line containing this SKU
      const matchingLine = lines.find(line => line.includes(skuUpper))

      if (matchingLine) {
        // Extract numbers from the line
        const numbers = matchingLine.match(/\b(\d+(?:\.\d+)?)\b/g)

        if (numbers && numbers.length > 0) {
          // Assume the last number in the count column is the counted quantity
          // (after SKU and expected, the count should be next)
          const countValue = numbers[numbers.length > 1 ? 1 : 0]

          items.push({
            sku: product.sku,
            productName: product.name,
            countedQuantity: parseFloat(countValue),
            confidence: result.data.confidence,
            rawValue: countValue
          })
        }
      }
    }

    // Extract count ID
    const countIdMatch = text.match(/ID:\s*([A-Z0-9]{8})/i)
    const countId = countIdMatch ? countIdMatch[1] : undefined

    await worker.terminate()

    onProgress?.({ status: 'Complete', progress: 100 })

    return {
      success: true,
      countId,
      items,
      totalProcessed: items.length,
      highConfidenceCount: items.filter(i => i.confidence >= 80).length,
      lowConfidenceCount: items.filter(i => i.confidence < 80).length,
      errors,
      processingTime: Date.now() - startTime
    }
  } catch (error) {
    errors.push(error instanceof Error ? error.message : 'Unknown OCR error')
    return {
      success: false,
      items: [],
      totalProcessed: 0,
      highConfidenceCount: 0,
      lowConfidenceCount: 0,
      errors,
      processingTime: Date.now() - startTime
    }
  }
}

// Preprocess image for better OCR results
export async function preprocessImage(
  imageFile: File
): Promise<{ processedBlob: Blob; adjustments: string[] }> {
  const adjustments: string[] = []

  return new Promise((resolve) => {
    const canvas = document.createElement('canvas')
    const ctx = canvas.getContext('2d')!
    const img = new Image()

    img.onload = () => {
      canvas.width = img.width
      canvas.height = img.height

      // Draw original image
      ctx.drawImage(img, 0, 0)

      // Get image data
      const imageData = ctx.getImageData(0, 0, canvas.width, canvas.height)
      const data = imageData.data

      // Convert to grayscale and increase contrast
      for (let i = 0; i < data.length; i += 4) {
        const gray = 0.299 * data[i] + 0.587 * data[i + 1] + 0.114 * data[i + 2]

        // Increase contrast
        const contrast = 1.5
        const factor = (259 * (contrast * 100 + 255)) / (255 * (259 - contrast * 100))
        const newGray = factor * (gray - 128) + 128

        // Apply threshold for cleaner text
        const threshold = newGray > 180 ? 255 : newGray < 60 ? 0 : newGray

        data[i] = threshold
        data[i + 1] = threshold
        data[i + 2] = threshold
      }

      ctx.putImageData(imageData, 0, 0)
      adjustments.push('grayscale', 'contrast-enhanced', 'threshold-applied')

      canvas.toBlob((blob) => {
        resolve({
          processedBlob: blob!,
          adjustments
        })
      }, 'image/png')
    }

    img.src = URL.createObjectURL(imageFile)
  })
}

// Validate OCR results against expected products
export function validateOCRResults(
  ocrResults: OCRCountResult[],
  expectedProducts: { sku: string }[]
): {
  matched: OCRCountResult[]
  unmatched: OCRCountResult[]
  missing: string[]
} {
  const expectedSkus = new Set(expectedProducts.map(p => p.sku.toUpperCase()))
  const matched: OCRCountResult[] = []
  const unmatched: OCRCountResult[] = []
  const foundSkus = new Set<string>()

  for (const result of ocrResults) {
    if (expectedSkus.has(result.sku.toUpperCase())) {
      matched.push(result)
      foundSkus.add(result.sku.toUpperCase())
    } else {
      unmatched.push(result)
    }
  }

  const missing = expectedProducts
    .filter(p => !foundSkus.has(p.sku.toUpperCase()))
    .map(p => p.sku)

  return { matched, unmatched, missing }
}
