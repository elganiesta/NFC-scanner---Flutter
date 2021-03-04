const start_scan = 'Start reading';
const scan_on = 'Stop reading';
const start_rescan = 'Scan again';
const enable_nfc = "Enable NFC";
const scanning = 'Scanning...';
const scan_error = 'Press Enable NFC';
const read_error = 'it can not scan this tag.';
const website = 'TagTap.co.uk';
const website_link = 'https://tagtap.co.uk';


//*important
/* 
(requires iOS 13.0 or later) 
(requires Android API level 19 or later)

android permissions :

<uses-permission android:name="android.permission.NFC" />
<uses-feature
        android:name="android.hardware.nfc"
        android:required="true" />

ios permissions :

Turn on Near Field Communication Tag Reading
navigate to Capabilities. Scroll down to 'Near Field 
Communication Tag Reading' and turn it on.
Adds the NFC tag-reading feature to the App ID.
Adds the Near Field Communication Tag Reader Session Formats Entitlement to the entitlements file.

<key>NFCReaderUsageDescription</key>
<string>...</string>

*/