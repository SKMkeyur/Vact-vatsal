import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class privacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
          style: TextStyle(
              fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 5,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context, false),
          /* onPressed: () => exit(0), */
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Protecting your private information is our priority. This Statement of Privacy applies to Vact, and Vact LLC and governs data collection and usage."
                  " For the purposes of this Privacy Policy, unless otherwise noted, all references to Vact LLC include Vact. The Vact application is a information application. "
                  "By using the Vact application, you consent to the data practices described in this statement.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "Collection of your Personal Information",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w800,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "We do not collect any personal information about you unless you voluntarily provide it to us. However,"
                    " you may be required to provide certain personal information to us when you elect to use certain products or services. These may include:"
                    " (a) registering for an account; (b) entering a sweepstakes or contest sponsored by us or one of our partners; "
                    "(c) signing up for special offers from selected third parties; (d) sending us an email message;"
                    " (e) submitting your credit card or other payment information when ordering and purchasing products and services. To wit, we will use your information for, but not limited to, communicating with you in relation to services and/or products you have requested from us. We also may gather additional personal or non-personal information in the future.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "Sharing Information with Third Parties",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w800,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "Vact does not sell, rent or lease its customer lists to third parties.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "Vact may share data with trusted partners to help perform statistical analysis,"
                    " send you email or postal mail, provide customer support, or arrange for deliveries."
                    " All such third parties are prohibited from using your personal information except to provide these services to Vact, "
                    "and they are required to maintain the confidentiality of your information.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "Vact may disclose your personal information, without notice, if required to do so by law or in the good faith belief that such action is necessary to: "
                    "(a) conform to the edicts of the law or comply with legal process served on Vact or the site; (b) protect and defend the rights or property of Vact; "
                    "and/or (c) act under exigent circumstances to protect the personal safety of users of Vact, or the public.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "Right to Deletion",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w800,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "Subject to certain exceptions set out below, on receipt of a verifiable request from you, we will:",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "Please note that we may not be able to comply with requests to delete your personal information if it is necessary to:",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "• Delete your personal information from our records; and",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "• Direct any service providers to delete your personal information from their records.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "• Complete the transaction for which the personal information was collected, fulfill the terms of a written warranty or product recall conducted in accordance with federal law, provide a good or service requested by you, or reasonably anticipated within the context of our ongoing business relationship with you,"
                    " or otherwise perform a contract This is a RocketLawyer.com document.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),

              SizedBox(
                height: 8.0,
              ),
              Text(
                "Children Under Thirteen",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w800,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "Vact does not knowingly collect personally identifiable information from children under the age of thirteen. If you are under the age of thirteen, you must ask your parent or guardian for permission to use this application.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),

              SizedBox(
                height: 8.0,
              ),
              Text(
                "E-mail Communications",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w800,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "From time to time, Vact may contact you via email for the purpose of providing announcements, promotional offers, alerts, confirmations, surveys, and/or other general communication. In order to improve our Services, we may receive a notification when you open an email from Vact or click on a link therein.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "If you would like to stop receiving marketing or promotional communications via email from Vact, you may opt out of such communications by clicking on the UNSUBSCRIBE button.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),

              SizedBox(
                height: 8.0,
              ),
              Text(
                "Changes to this Statement",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w800,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "Vact reserves the right to change this Privacy Policy from time to time. We will notify you about significant changes in the way we treat personal information by sending a notice to the primary email address specified in your account, by placing a prominent notice on our application, and/or by updating any privacy information. Your continued use of the application and/or Services available after such modifications will constitute your: (a) acknowledgment of the modified Privacy Policy; and (b) agreement to abide and be bound by that Policy.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "Contact Information",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w800,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "Vact welcomes your questions or comments regarding this Statement of Privacy. If you believe that Vact has not adhered to this Statement, please contact Vact at:",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),

              SizedBox(
                height: 8.0,
              ),
              Text(
                "Vact LLC between you and us;",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w800,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "• Detect security incidents, protect against malicious, deceptive, fraudulent, or illegal activity; or prosecute those responsible for that activity;",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "• Debug to identify and repair errors that impair existing intended functionality;",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "• Exercise free speech, ensure the right of another consumer to exercise his or her right of free speech, or exercise another right provided for by law;",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "• Comply with the California Electronic Communications Privacy Act;",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "• Engage in public or peer-reviewed scientific, historical, or statistical research in the public interest that adheres to all other applicable ethics and privacy laws, when our deletion of the information is likely to render impossible or seriously impair the achievement of such research, provided we have obtained your informed consent;",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "• Enable solely internal uses that are reasonably aligned with your expectations based on your relationship with us;",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "• Comply with an existing legal obligation; or",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "• Otherwise use your personal information, internally, in a lawful manner that is "
                    "compatible with the context in which you provided the information.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "This is a RocketLawyer.com document.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "Email Address:",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "main@vact.tech",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "Telephone number:",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
              Text(
                "6038511923",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),

              SizedBox(
                height: 8.0,
              ),
              Text(
                "Effective as of August 05, 2021",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
