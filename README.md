# skype8login
AutoIt Script to automate Skype 8 Desktop Application login.

Latest Skype 8 has changed internally a lot from automation point of view;
<ul>
  <li>Contacts no more stored in SQLite c:\Users\WIN_USERNAME\AppData\Roaming\Skype\SKYPE_USERNAME\main.db</li>
  <li>Instead of _IEAttach(), we need to use <a href="https://www.autoitscript.com/forum/topic/153520-iuiautomation-ms-framework-automate-chrome-ff-ie/">IUIAutomation MS framework</a></li>
  <li>Skype binary is now placed under PROGRAMFILES\Microsoft\Skype for Desktop\Skype.exe</li>
</ul>

This package will be compiled under AutoIt and will do following;

<ul>
  <li>Open Skype (if not already running)</li>
  <li>Click either "User another account" or "Sign in with Microsoft"</li>
  <li>Write Username & hit Enter</li>
  <li>Write Password & hit Enter</li>
</ul>

Details can be found here https://blog.teemya.com/2018/06/14/automate-skype-login-using-autoit/
