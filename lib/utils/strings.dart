// All UI strings in English and Hindi.
// Usage: AppStrings.t('key', lang)

class AppStrings {
  static const Map<String, Map<String, String>> _data = {
    // ── Auth ────────────────────────────────────────────────────────────
    'app_name': {'en': 'CANMET', 'hi': 'CANMET'},
    'app_tagline': {
      'en': 'Cancer Metabolic Management',
      'hi': 'कैंसर चयापचय प्रबंधन'
    },
    'login_title': {'en': 'Welcome Back', 'hi': 'वापसी पर स्वागत है'},
    'login_sub': {
      'en': 'Login to continue your health journey',
      'hi': 'अपनी स्वास्थ्य यात्रा जारी रखने के लिए लॉगिन करें'
    },
    'patient_id': {'en': 'Patient ID', 'hi': 'मरीज़ की आईडी'},
    'patient_id_hint': {'en': 'e.g. CNM-10234', 'hi': 'जैसे CNM-10234'},
    'password': {'en': 'Password', 'hi': 'पासवर्ड'},
    'password_hint': {'en': 'Enter your password', 'hi': 'पासवर्ड दर्ज करें'},
    'login_btn': {'en': 'Login', 'hi': 'लॉगिन करें'},
    'no_account': {'en': "Don't have an account? ", 'hi': 'अकाउंट नहीं है? '},
    'register_link': {'en': 'Register', 'hi': 'पंजीकरण करें'},
    'demo_note': {
      'en': 'Demo: Use any Patient ID and password to login.',
      'hi': 'डेमो: किसी भी मरीज़ आईडी और पासवर्ड से लॉगिन करें।'
    },
    'fields_required': {
      'en': 'Please fill all required fields.',
      'hi': 'कृपया सभी आवश्यक फ़ील्ड भरें।'
    },

    // ── Register ─────────────────────────────────────────────────────────
    'register_title': {'en': 'Create Account', 'hi': 'अकाउंट बनाएं'},
    'full_name': {'en': 'Full Name', 'hi': 'पूरा नाम'},
    'full_name_hint': {
      'en': 'Enter your full name',
      'hi': 'अपना पूरा नाम दर्ज करें'
    },
    'age': {'en': 'Age', 'hi': 'आयु'},
    'age_hint': {'en': 'e.g. 52', 'hi': 'जैसे 52'},
    'gender': {'en': 'Gender', 'hi': 'लिंग'},
    'male': {'en': 'Male', 'hi': 'पुरुष'},
    'female': {'en': 'Female', 'hi': 'महिला'},
    'other': {'en': 'Other', 'hi': 'अन्य'},
    'cancer_type': {'en': 'Cancer Type', 'hi': 'कैंसर का प्रकार'},
    'cancer_type_hint': {
      'en': 'e.g. Breast, Lung, Colorectal...',
      'hi': 'जैसे स्तन, फेफड़ा, कोलोरेक्टल...'
    },
    'hospital_id': {'en': 'Hospital ID', 'hi': 'अस्पताल आईडी'},
    'hospital_id_hint': {
      'en': 'e.g. AIIMS-2024-001',
      'hi': 'जैसे AIIMS-2024-001'
    },
    'mobile': {'en': 'Mobile Number', 'hi': 'मोबाइल नंबर'},
    'mobile_hint': {'en': '+91 98765 43210', 'hi': '+91 98765 43210'},
    'confirm_password': {
      'en': 'Confirm Password',
      'hi': 'पासवर्ड पुनः दर्ज करें'
    },
    'confirm_password_hint': {
      'en': 'Re-enter password',
      'hi': 'पासवर्ड दोबारा लिखें'
    },
    'register_btn': {'en': 'Register', 'hi': 'पंजीकरण करें'},
    'have_account': {
      'en': 'Already have an account? ',
      'hi': 'पहले से अकाउंट है? '
    },
    'login_link': {'en': 'Login', 'hi': 'लॉगिन करें'},
    'password_mismatch': {
      'en': 'Passwords do not match.',
      'hi': 'पासवर्ड मेल नहीं खाते।'
    },

    // ── Home ─────────────────────────────────────────────────────────────
    'good_morning': {'en': 'Good morning', 'hi': 'शुभ प्रभात'},
    'good_afternoon': {'en': 'Good afternoon', 'hi': 'शुभ दोपहर'},
    'good_evening': {'en': 'Good evening', 'hi': 'शुभ संध्या'},
    'treatment_day': {'en': 'Treatment day', 'hi': 'उपचार दिन'},
    'keep_it_up': {'en': 'Keep it up!', 'hi': 'बढ़िया कर रहे हैं!'},
    'adherence': {'en': 'Adherence', 'hi': 'पालन'},
    'modules_done': {'en': 'Modules', 'hi': 'मॉड्यूल'},
    'day_streak': {'en': 'Day Streak', 'hi': 'दिन की लकीर'},
    'your_modules': {'en': 'Your Modules', 'hi': 'आपके मॉड्यूल'},
    'todays_message': {'en': "Today's Message", 'hi': 'आज का संदेश'},
    'daily_tip': {
      'en': '💊 Take your medicines on time. Small habits lead to big recovery.',
      'hi': '💊 अपनी दवाएं समय पर लें। छोटी आदतें बड़ी रिकवरी लाती हैं।'
    },

    // ── Nav ──────────────────────────────────────────────────────────────
    'nav_home': {'en': 'Home', 'hi': 'होम'},
    'nav_track': {'en': 'Track', 'hi': 'ट्रैक'},
    'nav_profile': {'en': 'Profile', 'hi': 'प्रोफाइल'},

    // ── Module names / subtitles ──────────────────────────────────────────
    'edumet': {'en': 'EduMET', 'hi': 'EduMET'},
    'edumet_sub': {'en': 'Metabolic Education', 'hi': 'चयापचय शिक्षा'},
    'nutrimet': {'en': 'NutriMET', 'hi': 'NutriMET'},
    'nutrimet_sub': {'en': 'Healthy Eating', 'hi': 'स्वस्थ भोजन'},
    'physimet': {'en': 'PhysiMET', 'hi': 'PhysiMET'},
    'physimet_sub': {'en': 'Exercise', 'hi': 'व्यायाम'},
    'safemet': {'en': 'SafeMET', 'hi': 'SafeMET'},
    'safemet_sub': {'en': 'Clinical Safety', 'hi': 'नैदानिक सुरक्षा'},
    'trackmet': {'en': 'TrackMET', 'hi': 'TrackMET'},
    'trackmet_sub': {'en': 'Self Monitoring', 'hi': 'स्व-निगरानी'},
    'mindmet': {'en': 'MindMET', 'hi': 'MindMET'},
    'mindmet_sub': {'en': 'Stress & Sleep', 'hi': 'तनाव और नींद'},
    'medimet': {'en': 'MediMET', 'hi': 'MediMET'},
    'medimet_sub': {'en': 'Medication Adherence', 'hi': 'दवा का पालन'},

    // ── Module detail ─────────────────────────────────────────────────────
    'todays_tasks': {'en': "Today's Tasks", 'hi': 'आज के कार्य'},
    'key_message': {'en': 'Key Message', 'hi': 'मुख्य संदेश'},
    'daily_reminder': {'en': 'Daily Reminder', 'hi': 'दैनिक याद'},
    'task_progress': {'en': 'completed', 'hi': 'पूरा हुआ'},

    // ── Track ─────────────────────────────────────────────────────────────
    'track_title': {'en': 'Daily Health Log', 'hi': 'दैनिक स्वास्थ्य लॉग'},
    'track_sub': {
      'en': 'Record your readings every day',
      'hi': 'हर दिन अपनी रीडिंग दर्ज करें'
    },
    'blood_glucose': {'en': 'Blood Glucose', 'hi': 'रक्त शर्करा'},
    'fasting': {'en': 'Fasting (mg/dL)', 'hi': 'फास्टिंग (mg/dL)'},
    'post_meal': {'en': 'Post-meal (mg/dL)', 'hi': 'खाने के बाद (mg/dL)'},
    'blood_pressure': {'en': 'Blood Pressure', 'hi': 'रक्तचाप'},
    'systolic': {'en': 'Systolic (mmHg)', 'hi': 'सिस्टोलिक (mmHg)'},
    'diastolic': {'en': 'Diastolic (mmHg)', 'hi': 'डायस्टोलिक (mmHg)'},
    'weight_waist': {'en': 'Weight & Waist', 'hi': 'वज़न और कमर'},
    'weight': {'en': 'Weight (kg)', 'hi': 'वज़न (kg)'},
    'waist': {'en': 'Waist (cm)', 'hi': 'कमर (cm)'},
    'stress_sleep': {'en': 'Stress & Sleep', 'hi': 'तनाव और नींद'},
    'stress_score': {'en': 'Stress Score (0–10)', 'hi': 'तनाव स्कोर (0–10)'},
    'sleep_hours': {'en': 'Sleep (hours)', 'hi': 'नींद (घंटे)'},
    'save_log': {'en': "Save Today's Log", 'hi': 'आज का लॉग सेव करें'},
    'saved_ok': {
      'en': '✓  Saved successfully!',
      'hi': '✓  सफलतापूर्वक सेव हो गया!'
    },
    'warning_card': {
      'en':
          '🚨 Seek immediate help for: fever, vomiting, severe weakness, dizziness, or blood sugar persistently above 200 mg/dL.',
      'hi':
          '🚨 तुरंत मदद लें अगर: बुखार, उल्टी, गंभीर कमज़ोरी, चक्कर, या रक्त शर्करा लगातार 200 mg/dL से अधिक हो।'
    },

    // ── Profile ───────────────────────────────────────────────────────────
    'my_profile': {'en': 'My Profile', 'hi': 'मेरी प्रोफाइल'},
    'personal_info': {'en': 'Personal Information', 'hi': 'व्यक्तिगत जानकारी'},
    'settings': {'en': 'Settings', 'hi': 'सेटिंग्स'},
    'support': {'en': 'Support', 'hi': 'सहायता'},
    'language': {'en': 'Language', 'hi': 'भाषा'},
    'reminders': {'en': 'Reminders', 'hi': 'रिमाइंडर'},
    'ask_nurse': {'en': 'Ask-a-Nurse', 'hi': 'नर्स से पूछें'},
    'emergency': {'en': 'Emergency', 'hi': 'आपातकाल'},
    'logout': {'en': 'Logout', 'hi': 'लॉगआउट'},
    'logout_confirm': {
      'en': 'Are you sure you want to logout?',
      'hi': 'क्या आप वाकई लॉगआउट करना चाहते हैं?'
    },
    'cancel': {'en': 'Cancel', 'hi': 'रद्द करें'},
    'close': {'en': 'Close', 'hi': 'बंद करें'},
    'coming_soon': {'en': 'Coming soon!', 'hi': 'जल्द आ रहा है!'},
    'nurse_info': {
      'en': 'Nurse Helpline: 1800-XXX-XXXX\nMon–Sat: 9 AM – 6 PM',
      'hi': 'नर्स हेल्पलाइन: 1800-XXX-XXXX\nसोम–शनि: सुबह 9 बजे – शाम 6 बजे'
    },
    'emergency_info': {
      'en':
          'Emergency: 112\nAIIMS Helpline: 011-XXXX-XXXX\nCancer Helpline: 1800-XXX-XXXX',
      'hi':
          'आपातकाल: 112\nAIIMS हेल्पलाइन: 011-XXXX-XXXX\nकैंसर हेल्पलाइन: 1800-XXX-XXXX'
    },
  };

  static String t(String key, String lang) {
    final entry = _data[key];
    if (entry == null) return key;
    return entry[lang] ?? entry['en'] ?? key;
  }
}
