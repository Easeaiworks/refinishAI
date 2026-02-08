import Link from 'next/link'
import { ArrowLeft } from 'lucide-react'

export const metadata = {
  title: 'Terms of Service - RefinishAI',
  description: 'Terms of Service for RefinishAI auto body shop management software',
}

export default function TermsOfServicePage() {
  return (
    <div className="min-h-screen bg-gray-50">
      {/* Navigation */}
      <div className="bg-white border-b border-gray-200">
        <div className="max-w-4xl mx-auto px-6 py-4">
          <Link
            href="/dashboard"
            className="inline-flex items-center gap-2 text-slate-600 hover:text-slate-900 transition-colors"
          >
            <ArrowLeft className="w-4 h-4" />
            Back to Dashboard
          </Link>
        </div>
      </div>

      {/* Page Header Banner */}
      <div className="bg-gradient-to-r from-slate-800 to-slate-700 px-6 py-8">
        <div className="max-w-4xl mx-auto">
          <h1 className="text-3xl font-bold text-white mb-2">
            Terms of Service
          </h1>
          <p className="text-slate-300">
            Last updated: February 2026
          </p>
        </div>
      </div>

      {/* Content */}
      <div className="max-w-4xl mx-auto px-6 py-12">
        <div className="bg-white rounded-xl border border-gray-200 shadow-sm">
          <div className="p-8 space-y-8">
            {/* 1. Acceptance of Terms */}
            <section>
              <h2 className="text-xl font-bold text-gray-900 mb-4">
                1. Acceptance of Terms
              </h2>
              <div className="text-gray-700 space-y-4">
                <p>
                  By accessing and using the RefinishAI application and services (the "Service"), you accept and agree to be bound by the terms and provision of this agreement. These Terms of Service ("Terms") are entered into by and between RefinishAI Inc., a Canadian corporation ("Company," "we," "us," or "our"), and you or the organization you represent ("User," "you," or "your").
                </p>
                <p>
                  If you do not agree to abide by the above, please do not use this Service. Your continued use of the Service constitutes your acceptance of these Terms.
                </p>
              </div>
            </section>

            {/* 2. Description of Service */}
            <section>
              <h2 className="text-xl font-bold text-gray-900 mb-4">
                2. Description of Service
              </h2>
              <div className="text-gray-700 space-y-4">
                <p>
                  RefinishAI is a Software-as-a-Service (SaaS) platform designed to provide auto body shop management capabilities, including but not limited to: inventory management, estimates creation, invoice generation, analytics and reporting, and related tools ("Service").
                </p>
                <p>
                  The Service is provided on a subscription basis via web browser access. We reserve the right to modify, suspend, or discontinue the Service or any features or portions thereof at any time, with or without notice, subject to the limitations in Section 13 (Modifications to Terms).
                </p>
              </div>
            </section>

            {/* 3. User Accounts & Responsibilities */}
            <section>
              <h2 className="text-xl font-bold text-gray-900 mb-4">
                3. User Accounts & Responsibilities
              </h2>
              <div className="text-gray-700 space-y-4">
                <p>
                  <strong>Account Creation:</strong> To use the Service, you must create a user account and provide accurate, complete, and current information. You are responsible for maintaining the confidentiality of your password and account credentials and for all activities that occur under your account.
                </p>
                <p>
                  <strong>Account Responsibility:</strong> You agree to notify us immediately of any unauthorized use of your account or any other breach of security. You are liable for all activities conducted through your account, whether authorized or unauthorized.
                </p>
                <p>
                  <strong>Company Account:</strong> When you create an account, you may establish a company profile. Only authorized representatives of your company should have access to company accounts. You are responsible for managing user access and permissions within your company account.
                </p>
                <p>
                  <strong>Accurate Information:</strong> You agree to provide accurate, current, and complete information when registering and to maintain and update such information as needed. Providing false or incomplete information may result in account termination.
                </p>
              </div>
            </section>

            {/* 4. Subscription & Billing Terms */}
            <section>
              <h2 className="text-xl font-bold text-gray-900 mb-4">
                4. Subscription & Billing Terms
              </h2>
              <div className="text-gray-700 space-y-4">
                <p>
                  <strong>Subscription Plans:</strong> The Service is offered on a subscription basis. We offer monthly and annual billing options. Your subscription is associated with your company and applies to up to five (5) users per company account (as included in your plan).
                </p>
                <p>
                  <strong>Auto-Renewal:</strong> Your subscription will automatically renew at the end of each billing period unless you cancel your subscription before the renewal date. You will be charged the subscription fee for the renewal period using the payment method on file.
                </p>
                <p>
                  <strong>Payment Processing:</strong> Payments are processed through Stripe or other authorized payment processors. By providing payment information, you authorize us to charge your payment method for subscription fees and any applicable taxes.
                </p>
                <p>
                  <strong>Billing Cycle:</strong> For monthly subscriptions, billing occurs on the same date each month. For annual subscriptions, billing occurs annually on the anniversary of your subscription start date.
                </p>
                <p>
                  <strong>Failed Payments:</strong> If a payment fails, we will attempt to process it again. If payment cannot be collected, your access to the Service may be suspended until payment is received.
                </p>
                <p>
                  <strong>Cancellation:</strong> You may cancel your subscription at any time by accessing your account settings or contacting our support team. Cancellation will take effect at the end of your current billing period. No refunds are provided for partial billing periods, but you retain access to the Service until the end of your current billing period.
                </p>
                <p>
                  <strong>Price Changes:</strong> We reserve the right to adjust subscription pricing. We will provide at least thirty (30) days' notice of any price increases. Your continued use of the Service after price changes constitutes acceptance of new pricing.
                </p>
                <p>
                  <strong>Taxes:</strong> You are responsible for any applicable taxes, duties, or other governmental charges on your subscription fees. We will charge applicable sales tax as required by law.
                </p>
              </div>
            </section>

            {/* 5. User Limits */}
            <section>
              <h2 className="text-xl font-bold text-gray-900 mb-4">
                5. User Limits
              </h2>
              <div className="text-gray-700 space-y-4">
                <p>
                  <strong>Per-Company Limits:</strong> Each subscription grants access to up to five (5) users per company. A "user" is defined as a unique individual with login credentials to the Service associated with your company account.
                </p>
                <p>
                  <strong>Additional Users:</strong> If your company requires more than five (5) users, you must upgrade your plan or contact our sales team. Adding users beyond your plan limit may result in service suspension or charges for overage users.
                </p>
                <p>
                  <strong>User Management:</strong> You are responsible for managing which company employees and team members have access to the Service. Sharing login credentials between multiple individuals or using the Service by unauthorized parties is prohibited.
                </p>
              </div>
            </section>

            {/* 6. Acceptable Use Policy */}
            <section>
              <h2 className="text-xl font-bold text-gray-900 mb-4">
                6. Acceptable Use Policy
              </h2>
              <div className="text-gray-700 space-y-4">
                <p>
                  You agree not to use the Service in any manner that:
                </p>
                <ul className="list-disc list-inside space-y-2 ml-2">
                  <li>Violates any applicable law, regulation, or third-party rights</li>
                  <li>Infringes on intellectual property rights of others</li>
                  <li>Transmits viruses, malware, or harmful code</li>
                  <li>Attempts to gain unauthorized access to the Service or its systems</li>
                  <li>Uses automated tools, bots, or scrapers to access the Service</li>
                  <li>Interferes with or disrupts the Service or its servers</li>
                  <li>Reverses engineers, decompiles, or attempts to derive the source code</li>
                  <li>Resells, republishes, or redistributes the Service</li>
                  <li>Uses the Service for benchmarking or competitive analysis</li>
                  <li>Uploads illegal, defamatory, obscene, or abusive content</li>
                  <li>Harasses, threatens, or abuses other users</li>
                  <li>Uses the Service in any fraudulent or deceptive manner</li>
                  <li>Violates the intellectual property rights of RefinishAI or others</li>
                </ul>
                <p className="mt-4">
                  Violation of this policy may result in suspension or termination of your account without refund.
                </p>
              </div>
            </section>

            {/* 7. Intellectual Property */}
            <section>
              <h2 className="text-xl font-bold text-gray-900 mb-4">
                7. Intellectual Property
              </h2>
              <div className="text-gray-700 space-y-4">
                <p>
                  <strong>Company IP:</strong> All content, features, and functionality of the Service (including software, code, algorithms, design, layout, and graphics) are owned by RefinishAI Inc., its licensors, or other providers of such content and are protected by Canadian and international copyright, trademark, patent, and other intellectual property laws.
                </p>
                <p>
                  <strong>Limited License:</strong> Subject to your compliance with these Terms, we grant you a limited, non-exclusive, non-transferable, revocable license to access and use the Service solely for your company's internal business purposes. This license does not permit you to modify, copy, distribute, transmit, display, perform, reproduce, publish, or create derivative works of the Service.
                </p>
                <p>
                  <strong>Your Content:</strong> You retain all rights to data and content you upload to the Service ("Your Content"). However, you grant us a worldwide, non-exclusive, royalty-free license to use, store, process, and display Your Content as necessary to provide the Service. This license includes the right to make automated backups and to comply with legal requirements.
                </p>
                <p>
                  <strong>Feedback:</strong> Any feedback, suggestions, or ideas you provide about the Service may be used by us without restriction or compensation to you.
                </p>
              </div>
            </section>

            {/* 8. Data & Privacy */}
            <section>
              <h2 className="text-xl font-bold text-gray-900 mb-4">
                8. Data & Privacy
              </h2>
              <div className="text-gray-700 space-y-4">
                <p>
                  Your use of the Service is also governed by our Privacy Policy, which is incorporated by reference into these Terms. Please review our Privacy Policy at <Link href="/privacy" className="text-blue-600 hover:text-blue-800 underline">our privacy page</Link> to understand our privacy practices.
                </p>
                <p>
                  <strong>Data Security:</strong> We implement industry-standard security measures to protect Your Content from unauthorized access. However, no system is completely secure. We are not responsible for unauthorized access to data due to factors beyond our reasonable control.
                </p>
                <p>
                  <strong>Data Retention:</strong> Upon termination of your account or subscription, Your Content will be retained for thirty (30) days to allow for recovery or migration. After this period, Your Content will be permanently deleted. We retain the right to maintain automatic backups for a reasonable period in accordance with our backup policies.
                </p>
                <p>
                  <strong>Data Processing:</strong> By using the Service, you authorize us to process and store Your Content on our servers, which may be located in different jurisdictions. You are responsible for complying with any data residency or localization requirements applicable to your business.
                </p>
              </div>
            </section>

            {/* 9. Service Availability & SLA Disclaimer */}
            <section>
              <h2 className="text-xl font-bold text-gray-900 mb-4">
                9. Service Availability & SLA Disclaimer
              </h2>
              <div className="text-gray-700 space-y-4">
                <p>
                  <strong>Availability:</strong> We strive to maintain high availability and reliability of the Service. However, the Service is provided on an "as-is" and "as-available" basis. We do not guarantee uninterrupted or error-free access.
                </p>
                <p>
                  <strong>Scheduled Maintenance:</strong> We may conduct scheduled maintenance during periods of low usage, typically communicated in advance. During maintenance, the Service may be unavailable.
                </p>
                <p>
                  <strong>Unforeseeable Outages:</strong> We are not responsible for outages caused by circumstances beyond our reasonable control, including but not limited to: natural disasters, acts of God, internet service provider failures, DDoS attacks, power outages, or third-party service failures.
                </p>
                <p>
                  <strong>SLA Disclaimer:</strong> Except as expressly provided in a separate written Service Level Agreement signed by an authorized RefinishAI representative, there is no guarantee of specific uptime or availability. Any implied warranties regarding service availability are disclaimed.
                </p>
              </div>
            </section>

            {/* 10. Limitation of Liability */}
            <section>
              <h2 className="text-xl font-bold text-gray-900 mb-4">
                10. Limitation of Liability
              </h2>
              <div className="text-gray-700 space-y-4">
                <p>
                  <strong>Disclaimer:</strong> EXCEPT AS EXPRESSLY PROVIDED IN A WRITTEN SERVICE LEVEL AGREEMENT, THE SERVICE IS PROVIDED "AS-IS" AND "AS-AVAILABLE." REFINISHAI MAKES NO OTHER WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT, OR TITLE.
                </p>
                <p>
                  <strong>Limitation:</strong> TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, IN NO EVENT SHALL REFINISHAI BE LIABLE FOR: (A) ANY INDIRECT, INCIDENTAL, SPECIAL, PUNITIVE, OR CONSEQUENTIAL DAMAGES; (B) LOSS OF PROFITS, REVENUE, DATA, OR GOODWILL; (C) COST OF SUBSTITUTE GOODS OR SERVICES; OR (D) ANY CLAIM ARISING FROM YOUR USE OF THE SERVICE.
                </p>
                <p>
                  <strong>Cap on Liability:</strong> TO THE MAXIMUM EXTENT PERMITTED BY LAW, REFINISHAI'S TOTAL LIABILITY FOR ALL CLAIMS ARISING FROM THESE TERMS OR THE SERVICE SHALL NOT EXCEED THE TOTAL AMOUNT PAID BY YOU TO REFINISHAI IN THE TWELVE (12) MONTHS PRECEDING THE CLAIM.
                </p>
                <p>
                  <strong>Essential Terms:</strong> Some jurisdictions do not allow limitation of liability for certain types of damages. If you are in such a jurisdiction, the above limitations may not apply to you, but they will apply to the maximum extent permitted by your local law.
                </p>
              </div>
            </section>

            {/* 11. Indemnification */}
            <section>
              <h2 className="text-xl font-bold text-gray-900 mb-4">
                11. Indemnification
              </h2>
              <div className="text-gray-700 space-y-4">
                <p>
                  You agree to indemnify, defend, and hold harmless RefinishAI Inc., its officers, directors, employees, agents, licensors, and suppliers from and against any and all claims, losses, liabilities, damages, costs, and expenses (including reasonable attorneys' fees) arising from or related to:
                </p>
                <ul className="list-disc list-inside space-y-2 ml-2">
                  <li>Your use of the Service or violation of these Terms</li>
                  <li>Your violation of applicable laws or regulations</li>
                  <li>Your infringement of any third-party intellectual property rights</li>
                  <li>Any content you upload, transmit, or store on the Service</li>
                  <li>Your actions or omissions in connection with the Service</li>
                </ul>
                <p className="mt-4">
                  We will notify you of any such claim and cooperate with you in its defense. You shall not settle any claim without our prior written consent.
                </p>
              </div>
            </section>

            {/* 12. Termination */}
            <section>
              <h2 className="text-xl font-bold text-gray-900 mb-4">
                12. Termination
              </h2>
              <div className="text-gray-700 space-y-4">
                <p>
                  <strong>Termination by You:</strong> You may terminate your subscription and account at any time by providing written notice to support@refinishai.com. Termination will be effective at the end of your current billing period.
                </p>
                <p>
                  <strong>Termination by Us:</strong> We may terminate or suspend your account or Service access immediately, without notice, if: (a) you violate these Terms or any applicable law; (b) you engage in fraudulent or abusive behavior; (c) you violate the Acceptable Use Policy; or (d) we are required to do so by law.
                </p>
                <p>
                  <strong>Effect of Termination:</strong> Upon termination, your right to access the Service ceases immediately. You must delete all copies of any software we have provided. We may delete Your Content thirty (30) days after termination. No refunds are provided for early termination by us due to your breach of these Terms.
                </p>
                <p>
                  <strong>Survival:</strong> Sections 7 (Intellectual Property), 8 (Data & Privacy), 10 (Limitation of Liability), 11 (Indemnification), 14 (Governing Law), and any other sections that by their nature should survive termination, shall survive termination of these Terms.
                </p>
              </div>
            </section>

            {/* 13. Modifications to Terms */}
            <section>
              <h2 className="text-xl font-bold text-gray-900 mb-4">
                13. Modifications to Terms
              </h2>
              <div className="text-gray-700 space-y-4">
                <p>
                  <strong>Right to Modify:</strong> We reserve the right to modify these Terms at any time. Material changes will be communicated to you at least thirty (30) days in advance. Your continued use of the Service after modifications become effective constitutes your acceptance of the modified Terms.
                </p>
                <p>
                  <strong>Non-Material Changes:</strong> We may make non-material changes to these Terms at any time, such as correcting errors or clarifying existing terms. Such changes become effective immediately.
                </p>
                <p>
                  <strong>Notification:</strong> We will notify you of material changes by email or by posting a notice on the Service. It is your responsibility to check these Terms periodically for changes.
                </p>
              </div>
            </section>

            {/* 14. Governing Law */}
            <section>
              <h2 className="text-xl font-bold text-gray-900 mb-4">
                14. Governing Law
              </h2>
              <div className="text-gray-700 space-y-4">
                <p>
                  These Terms shall be governed by and construed in accordance with the laws of Canada and the Province of [PROVINCE PLACEHOLDER], without regard to its conflict of laws principles. You consent to the exclusive jurisdiction and venue of the courts located in [PROVINCE PLACEHOLDER], Canada.
                </p>
                <p>
                  <strong>Dispute Resolution:</strong> Any disputes arising from these Terms or the Service shall be resolved in accordance with the laws of the Province of [PROVINCE PLACEHOLDER]. Before pursuing litigation, we encourage you to attempt to resolve disputes informally by contacting our support team.
                </p>
              </div>
            </section>

            {/* 15. Contact Information */}
            <section>
              <h2 className="text-xl font-bold text-gray-900 mb-4">
                15. Contact Information
              </h2>
              <div className="text-gray-700 space-y-4">
                <p>
                  If you have any questions about these Terms, wish to provide notice under these Terms, or need to contact us regarding your account, please reach out to:
                </p>
                <div className="bg-gray-50 p-4 rounded-lg border border-gray-200 mt-4">
                  <p className="font-semibold text-gray-900">RefinishAI Inc.</p>
                  <p className="text-gray-700">Email: support@refinishai.com</p>
                  <p className="text-gray-700">Country: Canada</p>
                </div>
                <p className="mt-4">
                  We will respond to inquiries within five (5) business days. For urgent matters, please indicate this in your subject line.
                </p>
              </div>
            </section>

            {/* Additional Terms */}
            <section>
              <h2 className="text-xl font-bold text-gray-900 mb-4">
                16. Miscellaneous
              </h2>
              <div className="text-gray-700 space-y-4">
                <p>
                  <strong>Entire Agreement:</strong> These Terms, together with our Privacy Policy, constitute the entire agreement between you and RefinishAI regarding the Service and supersede all prior and contemporaneous agreements, understandings, and negotiations.
                </p>
                <p>
                  <strong>Severability:</strong> If any provision of these Terms is found to be invalid or unenforceable, that provision shall be modified to the minimum extent necessary to make it enforceable, and the remaining provisions shall remain in full force and effect.
                </p>
                <p>
                  <strong>Assignment:</strong> You may not assign or transfer these Terms or your rights hereunder without our prior written consent. We may assign these Terms to a successor or affiliate at any time. Any attempted assignment in violation of this provision is void.
                </p>
                <p>
                  <strong>No Waiver:</strong> Failure by either party to enforce any right or provision shall not constitute a waiver of that right or provision.
                </p>
                <p>
                  <strong>Independent Contractors:</strong> You and RefinishAI are independent contractors. Nothing in these Terms creates a partnership, joint venture, agency, or employment relationship.
                </p>
                <p>
                  <strong>Notices:</strong> Any notice to RefinishAI must be in writing and sent to the address above. Notices are effective upon receipt. Notices to you may be sent to the email address or physical address in your account.
                </p>
              </div>
            </section>

            {/* Final Note */}
            <section className="bg-blue-50 p-6 rounded-lg border border-blue-200">
              <p className="text-gray-700">
                <strong>Last Updated:</strong> February 2026
              </p>
              <p className="text-gray-700 mt-2">
                These Terms of Service were last updated on the date indicated above. Please review them periodically for changes. Your continued use of the Service indicates your acceptance of these Terms as amended.
              </p>
            </section>
          </div>
        </div>
      </div>

      {/* Footer spacing */}
      <div className="h-12"></div>
    </div>
  )
}
