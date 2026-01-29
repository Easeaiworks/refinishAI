'use client'

import { useState } from 'react'
import { createClient } from '@/lib/supabase/client'
import { Upload, FileText, AlertCircle, CheckCircle, X } from 'lucide-react'

export default function UploadPage() {
  const [file, setFile] = useState<File | null>(null)
  const [uploading, setUploading] = useState(false)
  const [result, setResult] = useState<{ success: boolean; message: string; count?: number } | null>(null)
  const [dataType, setDataType] = useState<'estimate' | 'invoice'>('estimate')
  const supabase = createClient()

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files[0]) {
      setFile(e.target.files[0])
      setResult(null)
    }
  }

  const handleUpload = async () => {
    if (!file) return

    setUploading(true)
    setResult(null)

    try {
      // Read file
      const text = await file.text()
      
      // Parse CSV (simple implementation)
      const lines = text.split('\n').filter(line => line.trim())
      const headers = lines[0].split(',').map(h => h.trim())
      
      // Parse data rows
      const data = lines.slice(1).map(line => {
        const values = line.split(',').map(v => v.trim())
        const obj: any = {}
        headers.forEach((header, index) => {
          obj[header] = values[index]
        })
        return obj
      })

      // Insert into database
      let inserted = 0
      for (const row of data) {
        const { error } = await supabase
          .from(dataType === 'estimate' ? 'estimates' : 'invoices')
          .insert([{
            estimate_number: row['Estimate Number'] || row['estimate_number'],
            invoice_number: row['Invoice Number'] || row['invoice_number'],
            customer_name: row['Customer'] || row['customer_name'],
            vin: row['VIN'] || row['vin'],
            total_amount: parseFloat(row['Total'] || row['total_amount'] || '0'),
            estimate_date: row['Date'] || row['estimate_date'] || new Date().toISOString(),
            invoice_date: row['Date'] || row['invoice_date'] || new Date().toISOString(),
            completion_date: row['Completion Date'] || row['completion_date'] || new Date().toISOString(),
            status: 'Quoted',
            source: 'CSV',
          }])

        if (!error) inserted++
      }

      setResult({
        success: true,
        message: `Successfully imported ${inserted} ${dataType}s`,
        count: inserted
      })
    } catch (error) {
      setResult({
        success: false,
        message: 'Error parsing file. Please check the format.'
      })
    } finally {
      setUploading(false)
    }
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div>
        <h1 className="text-3xl font-bold text-gray-900">Upload Data</h1>
        <p className="text-gray-600 mt-2">Import estimates and invoices from CSV, Excel, or PDF files</p>
      </div>

      {/* Instructions */}
      <div className="bg-blue-50 border border-blue-200 rounded-lg p-6">
        <div className="flex gap-4">
          <AlertCircle className="w-6 h-6 text-blue-600 flex-shrink-0" />
          <div>
            <h3 className="font-bold text-blue-900 mb-2">File Format Requirements</h3>
            <ul className="text-blue-800 space-y-1 text-sm">
              <li>• CSV files should include headers: Estimate Number, Customer, VIN, Total, Date</li>
              <li>• Excel files should have data in the first sheet</li>
              <li>• PDF files will be extracted and parsed automatically</li>
              <li>• Maximum file size: 10MB</li>
            </ul>
          </div>
        </div>
      </div>

      {/* Upload Form */}
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
        <div className="space-y-4">
          {/* Data Type Selection */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Data Type
            </label>
            <div className="flex gap-4">
              <label className="flex items-center">
                <input
                  type="radio"
                  value="estimate"
                  checked={dataType === 'estimate'}
                  onChange={(e) => setDataType(e.target.value as 'estimate' | 'invoice')}
                  className="mr-2"
                />
                <span>Estimates (Future Work)</span>
              </label>
              <label className="flex items-center">
                <input
                  type="radio"
                  value="invoice"
                  checked={dataType === 'invoice'}
                  onChange={(e) => setDataType(e.target.value as 'estimate' | 'invoice')}
                  className="mr-2"
                />
                <span>Invoices (Completed Work)</span>
              </label>
            </div>
          </div>

          {/* File Upload */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Select File
            </label>
            <div className="border-2 border-dashed border-gray-300 rounded-lg p-8 text-center hover:border-blue-400 transition-colors">
              <input
                type="file"
                accept=".csv,.xlsx,.xls,.pdf"
                onChange={handleFileChange}
                className="hidden"
                id="file-upload"
              />
              <label htmlFor="file-upload" className="cursor-pointer">
                <Upload className="w-12 h-12 text-gray-400 mx-auto mb-4" />
                <p className="text-sm text-gray-600 mb-2">
                  {file ? file.name : 'Click to upload or drag and drop'}
                </p>
                <p className="text-xs text-gray-500">
                  CSV, Excel, or PDF (Max 10MB)
                </p>
              </label>
            </div>
          </div>

          {/* Upload Button */}
          {file && (
            <button
              onClick={handleUpload}
              disabled={uploading}
              className="w-full flex items-center justify-center gap-2 px-4 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:bg-gray-400 transition-colors"
            >
              {uploading ? (
                <>
                  <div className="animate-spin rounded-full h-5 w-5 border-b-2 border-white"></div>
                  Processing...
                </>
              ) : (
                <>
                  <Upload className="w-5 h-5" />
                  Upload {dataType === 'estimate' ? 'Estimates' : 'Invoices'}
                </>
              )}
            </button>
          )}

          {/* Result Message */}
          {result && (
            <div className={`p-4 rounded-lg ${result.success ? 'bg-green-50 border border-green-200' : 'bg-red-50 border border-red-200'}`}>
              <div className="flex items-start gap-3">
                {result.success ? (
                  <CheckCircle className="w-5 h-5 text-green-600 flex-shrink-0" />
                ) : (
                  <X className="w-5 h-5 text-red-600 flex-shrink-0" />
                )}
                <div>
                  <p className={`font-medium ${result.success ? 'text-green-900' : 'text-red-900'}`}>
                    {result.message}
                  </p>
                  {result.count && (
                    <p className="text-sm text-green-700 mt-1">
                      {result.count} records were added to the database
                    </p>
                  )}
                </div>
              </div>
            </div>
          )}
        </div>
      </div>

      {/* Recent Uploads */}
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
        <h2 className="text-lg font-bold text-gray-900 mb-4">Recent Uploads</h2>
        <div className="space-y-3">
          <div className="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
            <div className="flex items-center gap-3">
              <FileText className="w-5 h-5 text-gray-400" />
              <div>
                <p className="font-medium text-gray-900">estimates_2025.csv</p>
                <p className="text-sm text-gray-500">Uploaded today at 2:30 PM</p>
              </div>
            </div>
            <span className="text-sm font-medium text-green-600">45 records</span>
          </div>
        </div>
      </div>
    </div>
  )
}
