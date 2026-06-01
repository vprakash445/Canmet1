import 'package:flutter/material.dart';

// ─── Data models ─────────────────────────────────────────────────────────────

class ModuleSection {
  final String titleEn;
  final String titleHi;
  final String bodyEn;
  final String bodyHi;
  // Language-specific image paths
  final String? imagePathEn;
  final String? imagePathHi;

  const ModuleSection({
    required this.titleEn,
    required this.titleHi,
    required this.bodyEn,
    required this.bodyHi,
    this.imagePathEn,
    this.imagePathHi,
    // Legacy single imagePath support
    String? imagePath,
  }) : imagePathEn = imagePath ?? imagePathEn,
       imagePathHi = imagePath ?? imagePathHi;

  String title(String lang) => lang == 'hi' ? titleHi : titleEn;
  String body(String lang) => lang == 'hi' ? bodyHi : bodyEn;
  
  /// Returns the correct image path for the given language
  String? imagePath(String lang) => lang == 'hi' ? imagePathHi : imagePathEn;
}

class ModuleData {
  final String id;
  final String nameEn;
  final String nameHi;
  final String subEn;
  final String subHi;
  final Color color;
  final IconData icon;
  final String keyMsgEn;
  final String keyMsgHi;
  final String dailyReminderEn;
  final String dailyReminderHi;
  final List<ModuleSection> sections;
  final List<String> tasksEn;
  final List<String> tasksHi;
  // Card image shown on home screen
  final String cardImage;

  const ModuleData({
    required this.id,
    required this.nameEn,
    required this.nameHi,
    required this.subEn,
    required this.subHi,
    required this.color,
    required this.icon,
    required this.keyMsgEn,
    required this.keyMsgHi,
    required this.dailyReminderEn,
    required this.dailyReminderHi,
    required this.sections,
    required this.tasksEn,
    required this.tasksHi,
    required this.cardImage,
  });

  String name(String lang) => lang == 'hi' ? nameHi : nameEn;
  String sub(String lang) => lang == 'hi' ? subHi : subEn;
  String keyMsg(String lang) => lang == 'hi' ? keyMsgHi : keyMsgEn;
  String dailyReminder(String lang) =>
      lang == 'hi' ? dailyReminderHi : dailyReminderEn;
  List<String> tasks(String lang) => lang == 'hi' ? tasksHi : tasksEn;
}



// ─── All 7 modules with full bilingual content ────────────────────────────────

final List<ModuleData> allModules = [
  // 1. EduMET
  ModuleData(
    id: 'edumet',
    cardImage: 'assets/images/modules/edumet_card.png',
    nameEn: 'EduMET',
    nameHi: 'EduMET',
    subEn: 'Metabolic Education',
    subHi: 'चयापचय शिक्षा',
    color: const Color(0xFF0F6E56),
    icon: Icons.psychology_outlined,
    keyMsgEn:
        '"Understanding your metabolic health is the first step to improving cancer treatment outcomes."',
    keyMsgHi:
        '"अपने चयापचय स्वास्थ्य को समझना कैंसर उपचार परिणामों में सुधार का पहला कदम है।"',
    dailyReminderEn:
        'Know your waist size. Waist circumference matters more than total weight for central obesity.',
    dailyReminderHi:
        'अपनी कमर का माप जानें। केंद्रीय मोटापे के लिए कमर की परिधि कुल वज़न से ज़्यादा महत्वपूर्ण है।',
    sections: const [
      ModuleSection(
        imagePathEn: 'assets/images/edumet/en/section1.png',
        imagePathHi: 'assets/images/edumet/hi/section1.png',
        titleEn: 'What is Metabolic Syndrome?',
        titleHi: 'मेटाबोलिक सिंड्रोम क्या है?',
        bodyEn:
            'Metabolic Syndrome is a cluster of five metabolic abnormalities that together increase your risk of heart disease and type 2 diabetes:\n\n'
            '• Abdominal obesity (excess fat around the belly)\n'
            '• High blood pressure (≥130/85 mmHg)\n'
            '• High fasting blood sugar (≥100 mg/dL)\n'
            '• High triglycerides (≥150 mg/dL)\n'
            '• Low HDL ("good") cholesterol\n\n'
            'Having 3 or more of these together = Metabolic Syndrome.',
        bodyHi:
            'मेटाबोलिक सिंड्रोम पाँच चयापचय असामान्यताओं का एक समूह है जो एक साथ हृदय रोग और टाइप 2 मधुमेह का जोखिम बढ़ाता है:\n\n'
            '• पेट की मोटापा (पेट के आसपास अतिरिक्त चर्बी)\n'
            '• उच्च रक्तचाप (≥130/85 mmHg)\n'
            '• उच्च फास्टिंग रक्त शर्करा (≥100 mg/dL)\n'
            '• उच्च ट्राइग्लिसराइड्स (≥150 mg/dL)\n'
            '• कम HDL ("अच्छा") कोलेस्ट्रॉल\n\n'
            'इनमें से 3 या अधिक एक साथ = मेटाबोलिक सिंड्रोम।',
      ),
      ModuleSection(
        imagePathEn: 'assets/images/edumet/en/section2.png',
        imagePathHi: 'assets/images/edumet/hi/section2.png',
        titleEn: 'Why Does It Matter During Cancer Treatment?',
        titleHi: 'कैंसर उपचार के दौरान यह क्यों महत्वपूर्ण है?',
        bodyEn:
            'Cancer treatment itself can trigger or worsen metabolic syndrome:\n\n'
            '• Chemotherapy drugs damage insulin-producing cells\n'
            '• Steroids used during chemo raise blood sugar temporarily\n'
            '• Reduced physical activity during treatment causes weight gain\n'
            '• Stress hormones (cortisol) increase blood sugar and fat storage\n\n'
            'Uncontrolled metabolic syndrome during cancer treatment leads to:\n'
            '→ Poor tolerance to chemotherapy\n'
            '→ Increased infection risk\n'
            '→ Slower recovery\n'
            '→ Higher risk of cancer recurrence',
        bodyHi:
            'कैंसर का उपचार खुद ही मेटाबोलिक सिंड्रोम को उत्पन्न या बिगाड़ सकता है:\n\n'
            '• कीमोथेरेपी दवाएं इंसुलिन बनाने वाली कोशिकाओं को नुकसान पहुँचाती हैं\n'
            '• कीमो के दौरान उपयोग किए जाने वाले स्टेरॉयड अस्थायी रूप से रक्त शर्करा बढ़ाते हैं\n'
            '• उपचार के दौरान कम शारीरिक गतिविधि से वज़न बढ़ता है\n'
            '• तनाव हार्मोन (कोर्टिसोल) रक्त शर्करा और चर्बी भंडारण बढ़ाते हैं\n\n'
            'कैंसर उपचार के दौरान अनियंत्रित मेटाबोलिक सिंड्रोम से:\n'
            '→ कीमोथेरेपी सहन करने में कठिनाई\n'
            '→ संक्रमण का बढ़ा जोखिम\n'
            '→ धीमी रिकवरी\n'
            '→ कैंसर की पुनरावृत्ति का अधिक जोखिम',
      ),
      ModuleSection(
        imagePathEn: 'assets/images/edumet/en/section3.png',
        imagePathHi: 'assets/images/edumet/hi/section3.png',
        titleEn: 'How to Identify Metabolic Syndrome',
        titleHi: 'मेटाबोलिक सिंड्रोम कैसे पहचानें',
        bodyEn:
            'Check yourself for these 5 criteria:\n\n'
            '1. Waist circumference: >88 cm (women) or >102 cm (men)\n'
            '2. Blood pressure: ≥130/85 mmHg\n'
            '3. Fasting blood glucose: ≥100 mg/dL\n'
            '4. Triglycerides: ≥150 mg/dL\n'
            '5. HDL cholesterol: <50 mg/dL (women) or <40 mg/dL (men)\n\n'
            'If you have 3 or more → you have Metabolic Syndrome. Inform your doctor.',
        bodyHi:
            'इन 5 मानदंडों के लिए खुद की जांच करें:\n\n'
            '1. कमर की परिधि: >88 cm (महिलाएं) या >102 cm (पुरुष)\n'
            '2. रक्तचाप: ≥130/85 mmHg\n'
            '3. फास्टिंग रक्त शर्करा: ≥100 mg/dL\n'
            '4. ट्राइग्लिसराइड्स: ≥150 mg/dL\n'
            '5. HDL कोलेस्ट्रॉल: <50 mg/dL (महिलाएं) या <40 mg/dL (पुरुष)\n\n'
            'अगर 3 या अधिक हैं → आपको मेटाबोलिक सिंड्रोम है। अपने डॉक्टर को बताएं।',
      ),
      ModuleSection(
        imagePathEn: 'assets/images/edumet/en/section4.png',
        imagePathHi: 'assets/images/edumet/hi/section4.png',
        titleEn: 'What You Can Do (Modifiable Risk Factors)',
        titleHi: 'आप क्या कर सकते हैं (परिवर्तनीय जोखिम कारक)',
        bodyEn:
            'These risk factors are in YOUR control:\n\n'
            '✓ Eat healthy — follow the 3:1 plate model (NutriMET)\n'
            '✓ Stay active — even 10 minutes of walking helps (PhysiMET)\n'
            '✓ Manage stress — calm breathing & sleep (MindMET)\n'
            '✓ Monitor daily — track glucose, BP, weight (TrackMET)\n'
            '✓ Take medicines — never skip medication (MediMET)\n'
            '✓ Stay safe — follow safety guidelines (SafeMET)',
        bodyHi:
            'ये जोखिम कारक आपके नियंत्रण में हैं:\n\n'
            '✓ स्वस्थ खाएं — 3:1 प्लेट मॉडल अपनाएं (NutriMET)\n'
            '✓ सक्रिय रहें — 10 मिनट की चहलकदमी भी मदद करती है (PhysiMET)\n'
            '✓ तनाव प्रबंधन — शांत श्वास और नींद (MindMET)\n'
            '✓ रोज़ाना निगरानी — ग्लूकोज, BP, वज़न ट्रैक करें (TrackMET)\n'
            '✓ दवाएं लें — कभी दवा न छोड़ें (MediMET)\n'
            '✓ सुरक्षित रहें — सुरक्षा दिशानिर्देशों का पालन करें (SafeMET)',
      ),
    ],
    tasksEn: [
      'Measure your waist circumference today',
      'Check your blood pressure',
      'Know your fasting blood sugar level',
      'Identify which risk factors apply to you',
      'Share your findings with your doctor',
    ],
    tasksHi: [
      'आज अपनी कमर की परिधि मापें',
      'अपना रक्तचाप जांचें',
      'अपना फास्टिंग रक्त शर्करा स्तर जानें',
      'पहचानें कि कौन से जोखिम कारक आप पर लागू होते हैं',
      'अपने डॉक्टर के साथ अपनी जानकारी साझा करें',
    ],
  ),

  // 2. NutriMET
  ModuleData(
    id: 'nutrimet',
    cardImage: 'assets/images/modules/nutrimet_card.png',
    nameEn: 'NutriMET',
    nameHi: 'NutriMET',
    subEn: 'Healthy Eating',
    subHi: 'स्वस्थ भोजन',
    color: const Color(0xFF1D9E75),
    icon: Icons.eco_outlined,
    keyMsgEn:
        '"Smart food choices build a strong metabolic shield for better cancer treatment outcomes."',
    keyMsgHi:
        '"स्मार्ट भोजन विकल्प बेहतर कैंसर उपचार परिणामों के लिए एक मज़बूत चयापचय ढाल बनाते हैं।"',
    dailyReminderEn:
        'Replace white rice with millet at one meal today. Include protein in every meal.',
    dailyReminderHi:
        'आज एक भोजन में सफेद चावल की जगह मिलेट लें। हर भोजन में प्रोटीन शामिल करें।',
    sections: const [
      ModuleSection(
        imagePathEn: 'assets/images/nutrimet/en/section1.png',
        imagePathHi: 'assets/images/nutrimet/hi/section1.png',
        titleEn: '🌾 Millet Swap Challenge',
        titleHi: '🌾 मिलेट स्वैप चैलेंज',
        bodyEn:
            'Replace at least ONE meal of white rice or maida with millets:\n\n'
            '• Ragi (finger millet) — very high in calcium and fiber\n'
            '• Jowar (sorghum) — gluten-free, good for digestion\n'
            '• Bajra (pearl millet) — iron-rich, great for energy\n\n'
            'WHY millets?\n'
            '→ Low glycemic index (raise blood sugar slowly)\n'
            '→ High fiber (keeps you full longer)\n'
            '→ Prevents insulin spikes after meals\n'
            '→ Supports weight management\n\n'
            'How to start: Replace morning rice with ragi porridge (ragi kanji) or add bajra to your roti.',
        bodyHi:
            'कम से कम एक भोजन में सफेद चावल या मैदा की जगह मिलेट लें:\n\n'
            '• रागी (फिंगर मिलेट) — कैल्शियम और फाइबर से भरपूर\n'
            '• ज्वार (सोरघम) — ग्लूटेन-मुक्त, पाचन के लिए अच्छा\n'
            '• बाजरा (पर्ल मिलेट) — आयरन-युक्त, ऊर्जा के लिए बेहतरीन\n\n'
            'मिलेट क्यों?\n'
            '→ कम ग्लाइसेमिक इंडेक्स (रक्त शर्करा धीरे-धीरे बढ़ाते हैं)\n'
            '→ उच्च फाइबर (आपको लंबे समय तक भरा रखता है)\n'
            '→ भोजन के बाद इंसुलिन स्पाइक्स रोकता है\n'
            '→ वज़न प्रबंधन में मदद करता है\n\n'
            'कैसे शुरू करें: सुबह के चावल की जगह रागी का दलिया (रागी कांजी) लें या बाजरे को अपनी रोटी में मिलाएं।',
      ),
      ModuleSection(
        imagePathEn: 'assets/images/nutrimet/en/section2.png',
        imagePathHi: 'assets/images/nutrimet/hi/section2.png',
        titleEn: '🍽️ The 3:1 Plate Model (ICMR Recommended)',
        titleHi: '🍽️ 3:1 प्लेट मॉडल (ICMR द्वारा अनुशंसित)',
        bodyEn:
            'Divide your plate into 4 parts:\n\n'
            '3 parts → Complex carbohydrates + vegetables\n'
            '  Example: millet roti + sabzi + salad\n\n'
            '1 part → Protein\n'
            '  Examples: dal, paneer, eggs, fish, chicken, soya\n\n'
            'This model:\n'
            '→ Keeps blood sugar stable\n'
            '→ Ensures adequate protein for muscle maintenance\n'
            '→ Provides fiber for gut health\n\n'
            'Avoid: Eating only carbohydrates at a meal (e.g. rice + roti with no protein or vegetables).',
        bodyHi:
            'अपनी थाली को 4 भागों में बाँटें:\n\n'
            '3 भाग → जटिल कार्बोहाइड्रेट + सब्जियां\n'
            '  उदाहरण: मिलेट की रोटी + सब्जी + सलाद\n\n'
            '1 भाग → प्रोटीन\n'
            '  उदाहरण: दाल, पनीर, अंडे, मछली, चिकन, सोया\n\n'
            'यह मॉडल:\n'
            '→ रक्त शर्करा स्थिर रखता है\n'
            '→ मांसपेशियों के रखरखाव के लिए पर्याप्त प्रोटीन सुनिश्चित करता है\n'
            '→ आंत स्वास्थ्य के लिए फाइबर प्रदान करता है\n\n'
            'बचें: एक भोजन में केवल कार्बोहाइड्रेट खाने से (जैसे चावल + रोटी बिना प्रोटीन या सब्जी के)।',
      ),
      ModuleSection(
        imagePathEn: 'assets/images/nutrimet/en/section3.png',
        imagePathHi: 'assets/images/nutrimet/hi/section3.png',
        titleEn: '🔍 Hidden Sugar Detective',
        titleHi: '🔍 छुपी चीनी का पता लगाएं',
        bodyEn:
            'Sugar is hidden in many "healthy" products. Watch out for:\n\n'
            '• Packaged fruit juices and health drinks (often 6–10 tsp sugar per pack)\n'
            '• Flavoured yogurt and sweetened milk\n'
            '• Breakfast cereals and biscuits\n'
            '• Ketchup, sauces, and processed foods\n\n'
            'Daily limits:\n'
            '→ Added sugar: less than 25 grams per day (about 5 teaspoons)\n'
            '→ Salt: less than 5 grams per day (about 1 teaspoon)\n\n'
            'Rule: If a packaged product lists sugar in the first 3 ingredients — avoid it.',
        bodyHi:
            'चीनी कई "स्वस्थ" उत्पादों में छुपी होती है। इन पर ध्यान दें:\n\n'
            '• पैकेज्ड फ्रूट जूस और हेल्थ ड्रिंक्स (अक्सर प्रति पैक 6–10 चम्मच चीनी)\n'
            '• फ्लेवर्ड दही और मीठा दूध\n'
            '• नाश्ते के अनाज और बिस्किट\n'
            '• केचप, सॉस और प्रोसेस्ड खाद्य पदार्थ\n\n'
            'दैनिक सीमाएं:\n'
            '→ अतिरिक्त चीनी: प्रति दिन 25 ग्राम से कम (लगभग 5 चम्मच)\n'
            '→ नमक: प्रति दिन 5 ग्राम से कम (लगभग 1 चम्मच)\n\n'
            'नियम: अगर किसी पैकेज्ड उत्पाद की पहली 3 सामग्री में चीनी है — उससे बचें।',
      ),
      ModuleSection(
        imagePathEn: 'assets/images/nutrimet/en/section4.png',
        imagePathHi: 'assets/images/nutrimet/hi/section4.png',
        titleEn: '🥜 Healthy Fats & Protein Targets',
        titleHi: '🥜 स्वस्थ वसा और प्रोटीन लक्ष्य',
        bodyEn:
            'Healthy fats (eat these):\n'
            '• Nuts: almonds, walnuts — 15 to 30 grams per day (1 small handful)\n'
            '• Oils: olive oil, mustard oil, rice bran oil\n'
            '• Seeds: flaxseeds, sesame — 1 tablespoon per day\n\n'
            'Protein target:\n'
            '→ 1.2 to 1.5 grams per kg of body weight per day\n'
            '→ Example: if you weigh 60 kg, aim for 72–90 g protein per day\n\n'
            'Unhealthy fats to reduce:\n'
            '• Vanaspati, dalda, refined oils\n'
            '• Fried snacks, processed meats\n'
            '• Full-fat dairy consumed in excess',
        bodyHi:
            'स्वस्थ वसा (ये खाएं):\n'
            '• मेवे: बादाम, अखरोट — प्रति दिन 15 से 30 ग्राम (1 छोटी मुट्ठी)\n'
            '• तेल: जैतून का तेल, सरसों का तेल, चावल की भूसी का तेल\n'
            '• बीज: अलसी, तिल — प्रति दिन 1 बड़ा चम्मच\n\n'
            'प्रोटीन लक्ष्य:\n'
            '→ शरीर के वज़न के प्रति kg 1.2 से 1.5 ग्राम प्रति दिन\n'
            '→ उदाहरण: अगर वज़न 60 kg है, तो प्रति दिन 72–90 g प्रोटीन का लक्ष्य रखें\n\n'
            'कम करने वाली अस्वस्थ वसा:\n'
            '• वनस्पति, डालडा, रिफाइंड तेल\n'
            '• तले हुए स्नैक्स, प्रोसेस्ड मांस\n'
            '• अधिक मात्रा में फुल-फैट डेयरी',
      ),
    ],
    tasksEn: [
      'Replace one meal with millet (ragi/jowar/bajra)',
      'Follow the 3:1 plate model at lunch',
      'Include protein in every meal today',
      'Eat a handful of nuts (almonds/walnuts)',
      'Avoid all sugary drinks today',
      'Check labels on any packaged food you eat',
    ],
    tasksHi: [
      'एक भोजन मिलेट (रागी/ज्वार/बाजरा) से बदलें',
      'दोपहर के भोजन में 3:1 प्लेट मॉडल अपनाएं',
      'आज हर भोजन में प्रोटीन शामिल करें',
      'मेवे (बादाम/अखरोट) की एक मुट्ठी खाएं',
      'आज सभी मीठे पेय से बचें',
      'जो भी पैकेज्ड खाना खाएं उसके लेबल देखें',
    ],
  ),

  // 3. PhysiMET
  ModuleData(
    id: 'physimet',
    cardImage: 'assets/images/modules/physimet_card.png',
    nameEn: 'PhysiMET',
    nameHi: 'PhysiMET',
    subEn: 'Exercise as Medicine',
    subHi: 'व्यायाम एक दवा है',
    color: const Color(0xFF185FA5),
    icon: Icons.directions_run_outlined,
    keyMsgEn:
        '"Exercise is medicine — even 10 minutes of movement helps your recovery."',
    keyMsgHi:
        '"व्यायाम एक दवा है — 10 मिनट की गतिविधि भी आपकी रिकवरी में मदद करती है।"',
    dailyReminderEn:
        'Walk 10 minutes after every meal. Move for 2 minutes every hour.',
    dailyReminderHi:
        'हर भोजन के बाद 10 मिनट चलें। हर घंटे 2 मिनट चलें।',
    sections: const [
      ModuleSection(
        imagePathEn: 'assets/images/physimet/en/section1.png',
        imagePathHi: 'assets/images/physimet/hi/section1.png',
        titleEn: '⏱️ Activity Snacking (Every Hour)',
        titleHi: '⏱️ एक्टिविटी स्नैकिंग (हर घंटे)',
        bodyEn:
            'Every 60 minutes of sitting, do 1–3 minutes of movement:\n\n'
            '• Walk inside your room or corridor\n'
            '• Stretch your arms above your head\n'
            '• Stretch your legs — flex and point your feet\n'
            '• Stand up and sit down slowly, 3–5 times\n'
            '• Shoulder rolls — 5 forward, 5 backward\n\n'
            'WHY this matters:\n'
            '→ Prolonged sitting causes blood sugar to rise\n'
            '→ Even short movement breaks significantly reduce glucose levels\n'
            '→ Prevents stiffness and blood clots during chemotherapy\n\n'
            'Set a phone alarm every 60 minutes as a reminder.',
        bodyHi:
            '60 मिनट बैठने के बाद 1–3 मिनट गतिविधि करें:\n\n'
            '• अपने कमरे या गलियारे में टहलें\n'
            '• अपने हाथों को सिर के ऊपर स्ट्रेच करें\n'
            '• अपने पैरों को स्ट्रेच करें — पैरों को फ्लेक्स और पॉइंट करें\n'
            '• धीरे खड़े हों और बैठें, 3–5 बार\n'
            '• कंधे घुमाएं — 5 आगे, 5 पीछे\n\n'
            'यह क्यों महत्वपूर्ण है:\n'
            '→ लंबे समय तक बैठने से रक्त शर्करा बढ़ती है\n'
            '→ छोटे movement breaks भी glucose स्तर को काफी कम करते हैं\n'
            '→ कीमोथेरेपी के दौरान अकड़न और रक्त के थक्कों को रोकता है\n\n'
            'याद दिलाने के लिए हर 60 मिनट में फोन अलार्म सेट करें।',
      ),
      ModuleSection(
        imagePathEn: 'assets/images/physimet/en/section2.png',
        imagePathHi: 'assets/images/physimet/hi/section2.png',
        titleEn: '🪑 Strength Exercises (Chair-Based)',
        titleHi: '🪑 शक्ति व्यायाम (कुर्सी-आधारित)',
        bodyEn:
            'Safe for all cancer patients, even during treatment:\n\n'
            'CHAIR SITS (most important):\n'
            '1. Sit on a sturdy chair, feet flat on the floor\n'
            '2. Slowly stand up (take 3 seconds)\n'
            '3. Slowly sit back down (take 3 seconds)\n'
            '4. Start with 5 reps, progress to 10–15 over weeks\n'
            '5. Do 2–3 sets per day\n\n'
            'WALL PUSH-UPS:\n'
            '1. Stand an arm\'s length from a wall\n'
            '2. Place hands at shoulder height\n'
            '3. Bend elbows and lean toward wall, push back\n'
            '4. Start with 5 reps, progress to 10\n\n'
            'CALF RAISES (seated or standing):\n'
            'Raise heels off the floor, hold 2 seconds, lower. 10 reps.',
        bodyHi:
            'सभी कैंसर रोगियों के लिए सुरक्षित, उपचार के दौरान भी:\n\n'
            'चेयर सिट्स (सबसे महत्वपूर्ण):\n'
            '1. एक मज़बूत कुर्सी पर बैठें, पैर ज़मीन पर सपाट\n'
            '2. धीरे खड़े हों (3 सेकंड लें)\n'
            '3. धीरे वापस बैठें (3 सेकंड लें)\n'
            '4. 5 रेप्स से शुरू करें, हफ्तों में 10–15 तक बढ़ाएं\n'
            '5. प्रति दिन 2–3 सेट करें\n\n'
            'वॉल पुश-अप्स:\n'
            '1. दीवार से एक हाथ की दूरी पर खड़े हों\n'
            '2. कंधे की ऊंचाई पर हाथ रखें\n'
            '3. कोहनियाँ मोड़ें और दीवार की ओर झुकें, वापस धकेलें\n'
            '4. 5 रेप्स से शुरू करें, 10 तक बढ़ाएं\n\n'
            'काफ रेज़ (बैठे या खड़े):\n'
            'एड़ी ज़मीन से ऊपर उठाएं, 2 सेकंड रोकें, नीचे करें। 10 रेप्स।',
      ),
      ModuleSection(
        imagePathEn: 'assets/images/physimet/en/section3.png',
        imagePathHi: 'assets/images/physimet/hi/section3.png',
        titleEn: '🚶 Brisk Walking (Main Cardio Exercise)',
        titleHi: '🚶 तेज़ चलना (मुख्य कार्डियो व्यायाम)',
        bodyEn:
            'Target: 20–30 minutes of brisk walking per day.\n\n'
            'What is "brisk"?\n'
            '→ You can talk but not sing while walking\n'
            '→ Your breathing is slightly faster than normal\n'
            '→ Roughly 100 steps per minute\n\n'
            'If 30 minutes feels too much:\n'
            '→ Split into 3 sessions of 10 minutes each\n'
            '→ Walk after breakfast, lunch, and dinner\n\n'
            'Safety during treatment:\n'
            '• Wear comfortable, well-fitting shoes\n'
            '• Walk on flat surfaces\n'
            '• Carry water\n'
            '• Stop if dizzy, short of breath, or chest pain\n'
            '• Reduce to gentle walking on chemo days',
        bodyHi:
            'लक्ष्य: प्रति दिन 20–30 मिनट तेज़ चलना।\n\n'
            '"तेज़" का क्या मतलब है?\n'
            '→ आप चलते समय बात कर सकते हैं लेकिन गा नहीं सकते\n'
            '→ आपकी सांस सामान्य से थोड़ी तेज़ है\n'
            '→ लगभग 100 कदम प्रति मिनट\n\n'
            'अगर 30 मिनट बहुत ज़्यादा लगे:\n'
            '→ 10-10 मिनट के 3 सत्रों में बाँटें\n'
            '→ नाश्ते, दोपहर और रात के खाने के बाद चलें\n\n'
            'उपचार के दौरान सुरक्षा:\n'
            '• आरामदायक, अच्छी तरह फिट होने वाले जूते पहनें\n'
            '• समतल सतह पर चलें\n'
            '• पानी साथ ले जाएं\n'
            '• चक्कर, सांस लेने में कठिनाई, या सीने में दर्द पर रुकें\n'
            '• कीमो के दिनों में हल्की चाल में कम करें',
      ),
      ModuleSection(
        imagePathEn: 'assets/images/physimet/en/section4.png',
        imagePathHi: 'assets/images/physimet/hi/section4.png',
        titleEn: '🍛 Post-Meal Walk (Very Important)',
        titleHi: '🍛 खाने के बाद टहलना (बहुत महत्वपूर्ण)',
        bodyEn:
            'Walk for 10 minutes within 30 minutes after eating.\n\n'
            'Why is this so important?\n'
            '→ Reduces post-meal blood sugar spikes by 30–40%\n'
            '→ Improves digestion and reduces bloating\n'
            '→ Helps the body use glucose for energy instead of storing it as fat\n'
            '→ Just 10 minutes is enough — you don\'t need to walk fast\n\n'
            'What if I cannot walk after meals?\n'
            '→ Even marching in place for 5–10 minutes while seated helps\n'
            '→ Gentle leg movements while seated also reduce sugar spikes',
        bodyHi:
            'खाने के 30 मिनट के भीतर 10 मिनट टहलें।\n\n'
            'यह क्यों इतना महत्वपूर्ण है?\n'
            '→ भोजन के बाद रक्त शर्करा की वृद्धि 30–40% कम होती है\n'
            '→ पाचन सुधरता है और पेट फूलना कम होता है\n'
            '→ शरीर ग्लूकोज को चर्बी के रूप में जमा करने के बजाय ऊर्जा के लिए उपयोग करता है\n'
            '→ केवल 10 मिनट पर्याप्त है — तेज़ चलना ज़रूरी नहीं\n\n'
            'अगर भोजन के बाद नहीं चल सकते?\n'
            '→ बैठे हुए 5–10 मिनट अपनी जगह पर कदम मिलाना भी मदद करता है\n'
            '→ बैठे-बैठे पैरों की हल्की हरकत भी शर्करा की वृद्धि कम करती है',
      ),
    ],
    tasksEn: [
      'Set phone alarm every 60 minutes to move',
      'Do 5–10 chair sits (morning)',
      'Do 5–10 chair sits (evening)',
      'Walk 10 minutes after lunch',
      'Walk 10 minutes after dinner',
      'Walk 20–30 minutes briskly today',
    ],
    tasksHi: [
      'हर 60 मिनट में चलने के लिए फोन अलार्म सेट करें',
      '5–10 चेयर सिट्स करें (सुबह)',
      '5–10 चेयर सिट्स करें (शाम)',
      'दोपहर के भोजन के बाद 10 मिनट चलें',
      'रात के खाने के बाद 10 मिनट चलें',
      'आज 20–30 मिनट तेज़ चलें',
    ],
  ),

  // 4. SafeMET
  ModuleData(
    id: 'safemet',
    cardImage: 'assets/images/modules/safemet_card.png',
    nameEn: 'SafeMET',
    nameHi: 'SafeMET',
    subEn: 'Clinical Safety',
    subHi: 'नैदानिक सुरक्षा',
    color: const Color(0xFFA32D2D),
    icon: Icons.shield_outlined,
    keyMsgEn:
        '"Early detection and daily monitoring keep you safe during cancer treatment."',
    keyMsgHi:
        '"जल्दी पहचान और दैनिक निगरानी कैंसर उपचार के दौरान आपको सुरक्षित रखती है।"',
    dailyReminderEn:
        'Check your blood sugar. Inspect your feet. Watch for warning signs.',
    dailyReminderHi:
        'अपनी रक्त शर्करा जांचें। पैरों की जांच करें। चेतावनी संकेतों पर नज़र रखें।',
    sections: const [
      ModuleSection(
        imagePathEn: 'assets/images/safemet/en/section1.png',
        imagePathHi: 'assets/images/safemet/hi/section1.png',
        titleEn: '🩸 Blood Sugar Safe Zone During Treatment',
        titleHi: '🩸 उपचार के दौरान रक्त शर्करा सुरक्षित क्षेत्र',
        bodyEn:
            'Target ranges during cancer treatment:\n\n'
            '• Fasting blood sugar: 100–140 mg/dL (acceptable: up to 180)\n'
            '• Post-meal blood sugar: 140–180 mg/dL (acceptable: up to 200)\n\n'
            'Why blood sugar control matters more during chemo:\n'
            '→ High blood sugar weakens immunity (already compromised by chemo)\n'
            '→ Increases infection risk at chemo site\n'
            '→ Slows wound healing\n'
            '→ Worsens fatigue and nausea side effects\n\n'
            'Steroid alert: If you are on dexamethasone or prednisolone:\n'
            '→ Blood sugar can spike to 250–300 mg/dL — this is common\n'
            '→ Monitor more frequently (4 times/day) during steroid doses\n'
            '→ Inform your doctor — insulin may be needed temporarily',
        bodyHi:
            'कैंसर उपचार के दौरान लक्ष्य सीमाएं:\n\n'
            '• फास्टिंग रक्त शर्करा: 100–140 mg/dL (स्वीकार्य: 180 तक)\n'
            '• भोजन के बाद रक्त शर्करा: 140–180 mg/dL (स्वीकार्य: 200 तक)\n\n'
            'कीमो के दौरान रक्त शर्करा नियंत्रण क्यों अधिक महत्वपूर्ण है:\n'
            '→ उच्च रक्त शर्करा प्रतिरक्षा को कमज़ोर करती है (पहले से ही कीमो से प्रभावित)\n'
            '→ कीमो साइट पर संक्रमण का जोखिम बढ़ता है\n'
            '→ घाव भरना धीमा होता है\n'
            '→ थकान और मतली के दुष्प्रभाव बिगड़ते हैं\n\n'
            'स्टेरॉयड अलर्ट: अगर आप डेक्सामेथासोन या प्रेडनिसोलोन पर हैं:\n'
            '→ रक्त शर्करा 250–300 mg/dL तक बढ़ सकती है — यह सामान्य है\n'
            '→ स्टेरॉयड खुराक के दौरान अधिक बार (4 बार/दिन) निगरानी करें\n'
            '→ अपने डॉक्टर को बताएं — अस्थायी रूप से इंसुलिन की ज़रूरत हो सकती है',
      ),
      ModuleSection(
        imagePathEn: 'assets/images/safemet/en/section2.png',
        imagePathHi: 'assets/images/safemet/hi/section2.png',
        titleEn: '🦶 Daily Foot Care Protocol',
        titleHi: '🦶 दैनिक पैर देखभाल प्रोटोकॉल',
        bodyEn:
            'Check your feet EVERY DAY — especially important during chemotherapy:\n\n'
            'What to look for:\n'
            '• Cuts, blisters, or open sores\n'
            '• Redness, swelling, or warmth in any area\n'
            '• Numbness or tingling (nerve damage from chemo)\n'
            '• Nail changes or infections\n'
            '• Dryness or cracks in the skin\n\n'
            'Daily foot care routine:\n'
            '1. Wash feet with mild soap and lukewarm water\n'
            '2. Dry thoroughly between toes\n'
            '3. Apply moisturizer (avoid between toes)\n'
            '4. Inspect all areas including between toes and sole\n'
            '5. Wear properly fitting socks (no tight bands)\n\n'
            'See your doctor immediately if you notice any sore, wound, or infection.',
        bodyHi:
            'हर दिन अपने पैरों की जांच करें — कीमोथेरेपी के दौरान विशेष रूप से महत्वपूर्ण:\n\n'
            'क्या देखें:\n'
            '• कट, छाले, या खुले घाव\n'
            '• किसी भी क्षेत्र में लालिमा, सूजन, या गर्मी\n'
            '• सुन्नपन या झुनझुनी (कीमो से तंत्रिका क्षति)\n'
            '• नाखून में बदलाव या संक्रमण\n'
            '• त्वचा में सूखापन या दरारें\n\n'
            'दैनिक पैर देखभाल दिनचर्या:\n'
            '1. हल्के साबुन और गुनगुने पानी से पैर धोएं\n'
            '2. अंगुलियों के बीच पूरी तरह सुखाएं\n'
            '3. मॉइस्चराइज़र लगाएं (अंगुलियों के बीच से बचें)\n'
            '4. अंगुलियों के बीच और तलवे सहित सभी क्षेत्रों की जांच करें\n'
            '5. सही फिट वाले मोजे पहनें (कोई टाइट बैंड नहीं)\n\n'
            'कोई भी घाव, ज़ख्म, या संक्रमण दिखने पर तुरंत डॉक्टर से मिलें।',
      ),
      ModuleSection(
        imagePathEn: 'assets/images/safemet/en/section3.png',
        imagePathHi: 'assets/images/safemet/hi/section3.png',
        titleEn: '⚠️ Warning Signs — Act Immediately',
        titleHi: '⚠️ चेतावनी संकेत — तुरंत कार्रवाई करें',
        bodyEn:
            'Go to hospital IMMEDIATELY if you experience:\n\n'
            '🔴 URGENT — call doctor / go to emergency:\n'
            '• Fever above 38°C (100.4°F)\n'
            '• Repeated vomiting (unable to keep fluids down)\n'
            '• Severe weakness or inability to stand\n'
            '• Dizziness or fainting\n'
            '• Chest pain or difficulty breathing\n'
            '• Blood sugar persistently above 300 mg/dL\n\n'
            '🟡 INFORM YOUR DOCTOR SOON:\n'
            '• Blood sugar consistently above 200 mg/dL for 2+ days\n'
            '• Blood pressure above 160/100 mmHg\n'
            '• Sudden weight gain of 2+ kg in a week\n'
            '• Any new wound, swelling, or skin change\n'
            '• Numbness or tingling in hands/feet',
        bodyHi:
            'तुरंत अस्पताल जाएं अगर आपको ये हो:\n\n'
            '🔴 अत्यावश्यक — डॉक्टर को कॉल करें / आपातकाल में जाएं:\n'
            '• 38°C (100.4°F) से अधिक बुखार\n'
            '• बार-बार उल्टी (तरल पदार्थ नहीं पी पा रहे)\n'
            '• गंभीर कमज़ोरी या खड़े होने में असमर्थता\n'
            '• चक्कर या बेहोशी\n'
            '• सीने में दर्द या सांस लेने में कठिनाई\n'
            '• रक्त शर्करा लगातार 300 mg/dL से अधिक\n\n'
            '🟡 जल्द डॉक्टर को बताएं:\n'
            '• 2+ दिनों से रक्त शर्करा लगातार 200 mg/dL से अधिक\n'
            '• रक्तचाप 160/100 mmHg से अधिक\n'
            '• एक हफ्ते में 2+ kg अचानक वज़न बढ़ना\n'
            '• कोई भी नया घाव, सूजन, या त्वचा में बदलाव\n'
            '• हाथों/पैरों में सुन्नपन या झुनझुनी',
      ),
    ],
    tasksEn: [
      'Check blood sugar (fasting) this morning',
      'Inspect both feet carefully today',
      'Record your blood pressure',
      'Review the warning signs list',
      'Report any new symptom to your doctor',
    ],
    tasksHi: [
      'आज सुबह रक्त शर्करा (फास्टिंग) जांचें',
      'आज दोनों पैरों की ध्यान से जांच करें',
      'अपना रक्तचाप दर्ज करें',
      'चेतावनी संकेतों की सूची देखें',
      'कोई भी नया लक्षण अपने डॉक्टर को बताएं',
    ],
  ),

  // 5. TrackMET
  ModuleData(
    id: 'trackmet',
    cardImage: 'assets/images/modules/trackmet_card.png',
    nameEn: 'TrackMET',
    nameHi: 'TrackMET',
    subEn: 'Self Monitoring',
    subHi: 'स्व-निगरानी',
    color: const Color(0xFF7F77DD),
    icon: Icons.show_chart_outlined,
    keyMsgEn:
        '"What you track, you can control — monitor your health every day."',
    keyMsgHi:
        '"जो आप ट्रैक करते हैं, उसे नियंत्रित कर सकते हैं — हर दिन अपने स्वास्थ्य की निगरानी करें।"',
    dailyReminderEn:
        'Log your blood sugar today. Use the Track tab to record all readings.',
    dailyReminderHi:
        'आज अपनी रक्त शर्करा लॉग करें। सभी रीडिंग दर्ज करने के लिए Track टैब का उपयोग करें।',
    sections: const [
      ModuleSection(
        imagePathEn: 'assets/images/trackmet/en/section1.png',
        imagePathHi: 'assets/images/trackmet/hi/section1.png',
        titleEn: '📋 What to Monitor and How Often',
        titleHi: '📋 क्या निगरानी करें और कितनी बार',
        bodyEn:
            'Daily monitoring:\n'
            '• Blood glucose — fasting (before breakfast) and post-meal (2 hrs after lunch)\n'
            '• Blood pressure — morning, before medication\n'
            '• Symptoms — any new or worsening symptoms\n\n'
            'Weekly monitoring:\n'
            '• Weight — same time, same clothes, ideally morning\n'
            '• Waist circumference — measure at belly button level\n\n'
            'Monthly (at clinic visit):\n'
            '• HbA1c (3-month blood sugar average)\n'
            '• Lipid profile (cholesterol, triglycerides)\n'
            '• Kidney and liver function tests',
        bodyHi:
            'दैनिक निगरानी:\n'
            '• रक्त शर्करा — फास्टिंग (नाश्ते से पहले) और भोजन के बाद (दोपहर के भोजन के 2 घंटे बाद)\n'
            '• रक्तचाप — सुबह, दवा से पहले\n'
            '• लक्षण — कोई भी नया या बिगड़ता लक्षण\n\n'
            'साप्ताहिक निगरानी:\n'
            '• वज़न — एक ही समय, एक ही कपड़े, आदर्श रूप से सुबह\n'
            '• कमर की परिधि — नाभि के स्तर पर मापें\n\n'
            'मासिक (क्लिनिक विज़िट पर):\n'
            '• HbA1c (3 महीने का रक्त शर्करा औसत)\n'
            '• लिपिड प्रोफाइल (कोलेस्ट्रॉल, ट्राइग्लिसराइड्स)\n'
            '• किडनी और लिवर फंक्शन टेस्ट',
      ),
      ModuleSection(
        imagePathEn: 'assets/images/trackmet/en/section2.png',
        imagePathHi: 'assets/images/trackmet/hi/section2.png',
        titleEn: '📏 Waist vs Weight: An Important Concept',
        titleHi: '📏 कमर बनाम वज़न: एक महत्वपूर्ण अवधारणा',
        bodyEn:
            'Many patients focus only on total weight — but waist circumference is MORE IMPORTANT for metabolic risk.\n\n'
            'Central obesity (fat around the belly) is what drives metabolic syndrome, not total body weight.\n\n'
            'You may have a normal BMI but still have dangerous belly fat.\n\n'
            'Safe waist targets:\n'
            '• Women: below 80 cm (ideal) / alert above 88 cm\n'
            '• Men: below 90 cm (ideal) / alert above 102 cm\n\n'
            'Track BOTH weight AND waist every week.\n'
            'If waist is increasing even if weight is stable → inform your doctor.',
        bodyHi:
            'कई मरीज़ केवल कुल वज़न पर ध्यान देते हैं — लेकिन चयापचय जोखिम के लिए कमर की परिधि अधिक महत्वपूर्ण है।\n\n'
            'केंद्रीय मोटापा (पेट के आसपास चर्बी) ही मेटाबोलिक सिंड्रोम को बढ़ावा देता है, कुल शरीर का वज़न नहीं।\n\n'
            'आपका BMI सामान्य हो सकता है लेकिन फिर भी खतरनाक पेट की चर्बी हो सकती है।\n\n'
            'सुरक्षित कमर लक्ष्य:\n'
            '• महिलाएं: 80 cm से नीचे (आदर्श) / 88 cm से ऊपर पर सतर्क\n'
            '• पुरुष: 90 cm से नीचे (आदर्श) / 102 cm से ऊपर पर सतर्क\n\n'
            'हर हफ्ते वज़न और कमर दोनों ट्रैक करें।\n'
            'अगर वज़न स्थिर हो लेकिन कमर बढ़ रही हो → अपने डॉक्टर को बताएं।',
      ),
      ModuleSection(
        imagePathEn: 'assets/images/trackmet/en/section3.png',
        imagePathHi: 'assets/images/trackmet/hi/section3.png',
        titleEn: '📈 Understanding Your Numbers',
        titleHi: '📈 अपने नंबर समझें',
        bodyEn:
            'Blood Sugar (glucose):\n'
            '  Normal fasting: 70–100 mg/dL\n'
            '  Pre-diabetes: 100–125 mg/dL\n'
            '  Diabetes: ≥126 mg/dL\n'
            '  During chemo (acceptable): up to 180 mg/dL\n\n'
            'Blood Pressure:\n'
            '  Normal: below 120/80 mmHg\n'
            '  Elevated: 120–129/<80 mmHg\n'
            '  High (Stage 1): 130–139/80–89 mmHg\n'
            '  High (Stage 2): ≥140/≥90 mmHg\n\n'
            'BMI (Body Mass Index):\n'
            '  Healthy: 18.5–22.9 kg/m² (Indian standards)\n'
            '  Overweight: 23–24.9\n'
            '  Obese: ≥25',
        bodyHi:
            'रक्त शर्करा (ग्लूकोज):\n'
            '  सामान्य फास्टिंग: 70–100 mg/dL\n'
            '  प्री-डायबिटीज: 100–125 mg/dL\n'
            '  मधुमेह: ≥126 mg/dL\n'
            '  कीमो के दौरान (स्वीकार्य): 180 mg/dL तक\n\n'
            'रक्तचाप:\n'
            '  सामान्य: 120/80 mmHg से नीचे\n'
            '  ऊंचा: 120–129/<80 mmHg\n'
            '  उच्च (स्टेज 1): 130–139/80–89 mmHg\n'
            '  उच्च (स्टेज 2): ≥140/≥90 mmHg\n\n'
            'BMI (बॉडी मास इंडेक्स):\n'
            '  स्वस्थ: 18.5–22.9 kg/m² (भारतीय मानक)\n'
            '  अधिक वज़न: 23–24.9\n'
            '  मोटापा: ≥25',
      ),
    ],
    tasksEn: [
      'Log fasting blood sugar in the Track tab',
      'Record blood pressure this morning',
      'Weigh yourself (same time as last week)',
      'Measure your waist circumference',
      'Note any new symptoms in your diary',
    ],
    tasksHi: [
      'Track टैब में फास्टिंग रक्त शर्करा लॉग करें',
      'आज सुबह रक्तचाप दर्ज करें',
      'अपना वज़न करें (पिछले हफ्ते के समान समय)',
      'कमर की परिधि मापें',
      'अपनी डायरी में कोई भी नया लक्षण नोट करें',
    ],
  ),

  // 6. MindMET
  ModuleData(
    id: 'mindmet',
    cardImage: 'assets/images/modules/mindmet_card.png',
    nameEn: 'MindMET',
    nameHi: 'MindMET',
    subEn: 'Stress & Sleep',
    subHi: 'तनाव और नींद',
    color: const Color(0xFFBA7517),
    icon: Icons.self_improvement_outlined,
    keyMsgEn:
        '"A calm mind supports a healthy body — manage stress to improve your recovery."',
    keyMsgHi:
        '"शांत मन स्वस्थ शरीर को सहारा देता है — रिकवरी सुधारने के लिए तनाव प्रबंधन करें।"',
    dailyReminderEn:
        'Spend 15 minutes in morning sunlight. Practice Calm Mind Breathing today.',
    dailyReminderHi:
        'आज 15 मिनट सुबह की धूप में बिताएं। आज शांत मन श्वास का अभ्यास करें।',
    sections: const [
      ModuleSection(
        imagePathEn: 'assets/images/mindmet/en/section1.png',
        imagePathHi: 'assets/images/mindmet/hi/section1.png',
        titleEn: '☀️ Morning Sunlight — The Golden 15 Minutes',
        titleHi: '☀️ सुबह की धूप — सुनहरे 15 मिनट',
        bodyEn:
            'Spend 15 minutes in morning sunlight every day (ideally before 9 AM).\n\n'
            'Why morning sunlight?\n'
            '→ Resets your body clock (circadian rhythm) → improves sleep at night\n'
            '→ Boosts vitamin D → important for immunity and bone health\n'
            '→ Reduces cortisol (stress hormone) naturally\n'
            '→ Improves mood and reduces depression\n'
            '→ Directly improves insulin sensitivity (helps blood sugar control)\n\n'
            'How to do it:\n'
            '• Sit near a window or in your balcony\n'
            '• Combine with gentle stretching or prayer\n'
            '• Avoid staring at the sun — face the sunlight, keep eyes relaxed\n\n'
            'On cloudy days: still go outside, indirect light still helps.',
        bodyHi:
            'हर दिन 15 मिनट सुबह की धूप में बिताएं (आदर्श रूप से सुबह 9 बजे से पहले)।\n\n'
            'सुबह की धूप क्यों?\n'
            '→ आपकी शारीरिक घड़ी (सर्कैडियन रिदम) रीसेट करती है → रात की नींद में सुधार\n'
            '→ विटामिन D बढ़ाती है → प्रतिरक्षा और हड्डी स्वास्थ्य के लिए महत्वपूर्ण\n'
            '→ कोर्टिसोल (तनाव हार्मोन) को स्वाभाविक रूप से कम करती है\n'
            '→ मूड सुधारती है और अवसाद कम करती है\n'
            '→ सीधे इंसुलिन संवेदनशीलता में सुधार करती है (रक्त शर्करा नियंत्रण में मदद)\n\n'
            'कैसे करें:\n'
            '• खिड़की के पास या अपनी बालकनी में बैठें\n'
            '• हल्की स्ट्रेचिंग या प्रार्थना के साथ मिलाएं\n'
            '• सूर्य की ओर सीधे न देखें — धूप की ओर मुँह करें, आँखें शांत रखें\n\n'
            'बादल वाले दिनों में: फिर भी बाहर जाएं, अप्रत्यक्ष प्रकाश भी मदद करता है।',
      ),
      ModuleSection(
        imagePathEn: 'assets/images/mindmet/en/section2.png',
        imagePathHi: 'assets/images/mindmet/hi/section2.png',
        titleEn: '🧘 Calm Mind Breathing Technique (4-4-6)',
        titleHi: '🧘 शांत मन श्वास तकनीक (4-4-6)',
        bodyEn:
            'Practice this simple breathing technique for 5 minutes every day:\n\n'
            'Steps:\n'
            '1. Sit comfortably — on a chair or cross-legged on the floor\n'
            '2. Close your eyes and relax your shoulders\n'
            '3. Inhale slowly through your nose — count 4 seconds\n'
            '4. Hold your breath — count 4 seconds\n'
            '5. Exhale slowly through your mouth — count 6 seconds\n'
            '6. Repeat 5–10 times\n\n'
            'What this does:\n'
            '→ Activates the parasympathetic nervous system (calming response)\n'
            '→ Lowers cortisol by up to 20% in one session\n'
            '→ Reduces blood pressure\n'
            '→ Improves oxygen delivery to healing tissues\n\n'
            'Best times: Morning after sunlight, and just before bed.',
        bodyHi:
            'हर दिन 5 मिनट के लिए यह सरल श्वास तकनीक का अभ्यास करें:\n\n'
            'चरण:\n'
            '1. आराम से बैठें — कुर्सी पर या ज़मीन पर क्रॉस-लेग्ड\n'
            '2. आँखें बंद करें और कंधे शिथिल करें\n'
            '3. नाक से धीरे सांस लें — 4 सेकंड गिनें\n'
            '4. सांस रोकें — 4 सेकंड गिनें\n'
            '5. मुँह से धीरे सांस छोड़ें — 6 सेकंड गिनें\n'
            '6. 5–10 बार दोहराएं\n\n'
            'यह क्या करता है:\n'
            '→ पैरासिम्पेथेटिक तंत्रिका तंत्र को सक्रिय करता है (शांत करने वाली प्रतिक्रिया)\n'
            '→ एक सत्र में कोर्टिसोल को 20% तक कम करता है\n'
            '→ रक्तचाप कम करता है\n'
            '→ ठीक होने वाले ऊतकों तक ऑक्सीजन वितरण में सुधार करता है\n\n'
            'सर्वोत्तम समय: धूप के बाद सुबह, और सोने से ठीक पहले।',
      ),
      ModuleSection(
        imagePathEn: 'assets/images/mindmet/en/section3.png',
        imagePathHi: 'assets/images/mindmet/hi/section3.png',
        titleEn: '😴 Sleep Hygiene — The Dark Protocol',
        titleHi: '😴 नींद की स्वच्छता — डार्क प्रोटोकॉल',
        bodyEn:
            'Good sleep is critical for metabolic health and cancer recovery.\n\n'
            'Target: 7–8 hours of quality sleep per night.\n\n'
            'The Dark Protocol (do these every night):\n'
            '• 1 hour before bed — turn off all screens (phone, TV, tablet)\n'
            '• Keep bedroom as dark as possible (use blackout curtains)\n'
            '• Keep bedroom quiet and slightly cool\n'
            '• Set a fixed sleep time and wake time — even on weekends\n'
            '• Avoid eating heavy meals within 2 hours of sleep\n\n'
            'Why sleep matters for metabolism:\n'
            '→ Poor sleep raises blood sugar by 15–20% the next morning\n'
            '→ Sleep deprivation increases hunger hormones (ghrelin)\n'
            '→ Cortisol rises with poor sleep → fat storage increases\n'
            '→ Growth hormone (repairs tissue) released mainly during deep sleep',
        bodyHi:
            'अच्छी नींद चयापचय स्वास्थ्य और कैंसर की रिकवरी के लिए महत्वपूर्ण है।\n\n'
            'लक्ष्य: प्रति रात 7–8 घंटे की गुणवत्तापूर्ण नींद।\n\n'
            'डार्क प्रोटोकॉल (हर रात ये करें):\n'
            '• सोने से 1 घंटे पहले — सभी स्क्रीन बंद करें (फोन, टीवी, टैबलेट)\n'
            '• बेडरूम यथासंभव अंधेरा रखें (ब्लैकआउट पर्दे उपयोग करें)\n'
            '• बेडरूम शांत और थोड़ा ठंडा रखें\n'
            '• सोने का एक निश्चित समय और उठने का समय तय करें — सप्ताहांत पर भी\n'
            '• सोने के 2 घंटे के भीतर भारी भोजन से बचें\n\n'
            'चयापचय के लिए नींद क्यों महत्वपूर्ण है:\n'
            '→ खराब नींद अगली सुबह रक्त शर्करा 15–20% बढ़ाती है\n'
            '→ नींद की कमी भूख हार्मोन (घ्रेलिन) बढ़ाती है\n'
            '→ खराब नींद से कोर्टिसोल बढ़ता है → चर्बी भंडारण बढ़ता है\n'
            '→ वृद्धि हार्मोन (ऊतक मरम्मत करता है) मुख्य रूप से गहरी नींद के दौरान निकलता है',
      ),
    ],
    tasksEn: [
      'Sit in morning sunlight for 15 minutes',
      'Practice 4-4-6 breathing for 5 minutes',
      'Rate your stress today (in Track tab)',
      'Log your sleep hours (in Track tab)',
      'Put phone away 1 hour before bedtime tonight',
    ],
    tasksHi: [
      '15 मिनट सुबह की धूप में बैठें',
      '5 मिनट 4-4-6 श्वास का अभ्यास करें',
      'आज अपना तनाव स्तर रेट करें (Track टैब में)',
      'नींद के घंटे लॉग करें (Track टैब में)',
      'आज रात सोने से 1 घंटे पहले फोन रख दें',
    ],
  ),

  // 7. MediMET
  ModuleData(
    id: 'medimet',
    cardImage: 'assets/images/modules/medimet_card.png',
    nameEn: 'MediMET',
    nameHi: 'MediMET',
    subEn: 'Medication Adherence',
    subHi: 'दवा का पालन',
    color: const Color(0xFF3B6D11),
    icon: Icons.medication_outlined,
    keyMsgEn:
        '"Taking your medicines correctly and regularly is essential for successful treatment and recovery."',
    keyMsgHi:
        '"दवाएं सही तरीके से और नियमित रूप से लेना सफल उपचार और रिकवरी के लिए आवश्यक है।"',
    dailyReminderEn:
        'Take your medicines on time. Set a phone reminder right now if you haven\'t already.',
    dailyReminderHi:
        'अपनी दवाएं समय पर लें। अगर अभी तक नहीं किया है तो अभी फोन रिमाइंडर सेट करें।',
    sections: const [
      ModuleSection(
        imagePathEn: 'assets/images/medimet/en/section1.png',
        imagePathHi: 'assets/images/medimet/hi/section1.png',
        titleEn: '⏰ Take On Time, Every Single Day',
        titleHi: '⏰ हर एक दिन, समय पर लें',
        bodyEn:
            'Why timing matters:\n'
            '→ Most medications maintain their effect through steady blood levels\n'
            '→ Irregular timing causes drug levels to drop → reduces effectiveness\n'
            '→ For diabetes medicines: timing directly affects blood sugar control\n'
            '→ For cancer medicines: fixed schedules prevent dangerous peaks and troughs\n\n'
            'How to build a medication habit:\n'
            '1. Take medicine at the same time every day\n'
            '2. Link it to a daily routine (e.g. after brushing teeth, after morning tea)\n'
            '3. Set a phone alarm — label it clearly (e.g. "Metformin 500mg")\n'
            '4. Use a weekly pill organizer (pillbox)\n'
            '5. Keep a simple medication chart on the fridge',
        bodyHi:
            'समय क्यों मायने रखता है:\n'
            '→ अधिकांश दवाएं स्थिर रक्त स्तर के माध्यम से अपना प्रभाव बनाए रखती हैं\n'
            '→ अनियमित समय से दवा का स्तर गिरता है → प्रभावशीलता कम होती है\n'
            '→ मधुमेह की दवाओं के लिए: समय सीधे रक्त शर्करा नियंत्रण को प्रभावित करता है\n'
            '→ कैंसर की दवाओं के लिए: निश्चित कार्यक्रम खतरनाक उतार-चढ़ाव रोकते हैं\n\n'
            'दवा की आदत कैसे बनाएं:\n'
            '1. हर दिन एक ही समय पर दवा लें\n'
            '2. इसे दैनिक दिनचर्या से जोड़ें (जैसे दाँत साफ करने के बाद, सुबह की चाय के बाद)\n'
            '3. फोन अलार्म सेट करें — स्पष्ट लेबल करें (जैसे "Metformin 500mg")\n'
            '4. साप्ताहिक पिल ऑर्गेनाइज़र (pillbox) उपयोग करें\n'
            '5. फ्रिज पर एक सरल दवा चार्ट रखें',
      ),
      ModuleSection(
        imagePathEn: 'assets/images/medimet/en/section2.png',
        imagePathHi: 'assets/images/medimet/hi/section2.png',
        titleEn: '🚫 Never Skip — Never Double',
        titleHi: '🚫 कभी न छोड़ें — कभी दोगुना न लें',
        bodyEn:
            'NEVER skip medicines even if:\n'
            '• You are feeling better (the medicine is working — keep taking it)\n'
            '• You have side effects (talk to doctor, do not stop on your own)\n'
            '• You are fasting for religious reasons (discuss timing adjustment with doctor)\n\n'
            'If you MISSED a dose:\n'
            '→ If you remember within a few hours: take it immediately\n'
            '→ If it is almost time for your next dose: skip the missed one\n'
            '→ NEVER take two doses at once to make up for a missed one\n\n'
            'If you miss 2 or more doses:\n'
            '→ Call your doctor or nurse immediately\n'
            '→ Do not attempt to self-adjust your medication schedule',
        bodyHi:
            'दवाएं कभी न छोड़ें, भले ही:\n'
            '• आप बेहतर महसूस कर रहे हों (दवा काम कर रही है — लेते रहें)\n'
            '• दुष्प्रभाव हों (डॉक्टर से बात करें, खुद न रोकें)\n'
            '• धार्मिक कारणों से उपवास कर रहे हों (डॉक्टर से समय समायोजन पर चर्चा करें)\n\n'
            'अगर खुराक छूट गई:\n'
            '→ अगर कुछ घंटों के भीतर याद आए: तुरंत लें\n'
            '→ अगर अगली खुराक का लगभग समय हो: छूटी हुई खुराक छोड़ दें\n'
            '→ छूटी हुई खुराक की भरपाई के लिए कभी दो खुराक एक साथ न लें\n\n'
            'अगर 2 या अधिक खुराक छूट गई:\n'
            '→ तुरंत अपने डॉक्टर या नर्स को कॉल करें\n'
            '→ खुद दवा का शेड्यूल समायोजित करने की कोशिश न करें',
      ),
      ModuleSection(
        imagePathEn: 'assets/images/medimet/en/section3.png',
        imagePathHi: 'assets/images/medimet/hi/section3.png',
        titleEn: '💊 Managing Side Effects',
        titleHi: '💊 दुष्प्रभाव प्रबंधन',
        bodyEn:
            'Common side effects and how to manage them:\n\n'
            'NAUSEA (Metformin, chemo drugs):\n'
            '• Take medicine with food (not on empty stomach)\n'
            '• Eat small, frequent meals\n'
            '• Ginger tea or ginger chews can help\n'
            '• Tell your doctor if severe — anti-nausea medicine is available\n\n'
            'DIZZINESS (BP medicines):\n'
            '• Rise slowly from sitting or lying position\n'
            '• Sit on bed edge for 30 seconds before standing\n'
            '• Drink adequate water\n\n'
            'FATIGUE:\n'
            '• Rest when needed — do not push through severe fatigue\n'
            '• Light activity (walking) actually reduces chemo-related fatigue\n\n'
            'NEVER stop any medicine without consulting your doctor.',
        bodyHi:
            'सामान्य दुष्प्रभाव और उन्हें कैसे प्रबंधित करें:\n\n'
            'मतली (Metformin, कीमो दवाएं):\n'
            '• दवा खाने के साथ लें (खाली पेट नहीं)\n'
            '• छोटे, बार-बार भोजन करें\n'
            '• अदरक की चाय या अदरक कैंडी मदद कर सकती है\n'
            '• गंभीर होने पर डॉक्टर को बताएं — एंटी-नॉज़िया दवा उपलब्ध है\n\n'
            'चक्कर (BP दवाएं):\n'
            '• बैठे या लेटे हुए से धीरे उठें\n'
            '• खड़े होने से पहले 30 सेकंड बिस्तर के किनारे पर बैठें\n'
            '• पर्याप्त पानी पिएं\n\n'
            'थकान:\n'
            '• ज़रूरत पड़ने पर आराम करें — गंभीर थकान के दौरान जोर न दें\n'
            '• हल्की गतिविधि (चलना) वास्तव में कीमो से संबंधित थकान कम करती है\n\n'
            'अपने डॉक्टर से परामर्श किए बिना कोई भी दवा कभी न बंद करें।',
      ),
      ModuleSection(
        imagePathEn: 'assets/images/medimet/en/section4.png',
        imagePathHi: 'assets/images/medimet/hi/section4.png',
        titleEn: '📦 Medicine Storage & Organization',
        titleHi: '📦 दवा भंडारण और व्यवस्था',
        bodyEn:
            'Proper storage:\n'
            '• Store in a cool, dry place — away from heat and humidity\n'
            '• Bathroom medicine cabinets are NOT ideal (too humid)\n'
            '• Keep insulin in the refrigerator (not in the freezer)\n'
            '• Keep medicines away from children\n'
            '• Check expiry dates monthly — discard expired medicines safely\n\n'
            'Organization system:\n'
            '• Use a labelled pillbox with 7 compartments (one per day)\n'
            '• Fill your pillbox every Sunday for the coming week\n'
            '• Keep a written medicine list with doses and times\n'
            '• Share the list with a family member\n'
            '• Carry a copy of your medicine list to every clinic visit',
        bodyHi:
            'उचित भंडारण:\n'
            '• ठंडी, सूखी जगह पर रखें — गर्मी और नमी से दूर\n'
            '• बाथरूम की दवा कैबिनेट आदर्श नहीं है (बहुत नमी)\n'
            '• इंसुलिन रेफ्रिजरेटर में रखें (फ्रीज़र में नहीं)\n'
            '• दवाएं बच्चों से दूर रखें\n'
            '• हर महीने एक्सपायरी डेट जांचें — एक्सपायर्ड दवाएं सुरक्षित रूप से हटाएं\n\n'
            'संगठन प्रणाली:\n'
            '• 7 खानों वाला लेबल किया हुआ pillbox उपयोग करें (प्रत्येक दिन के लिए एक)\n'
            '• आने वाले सप्ताह के लिए हर रविवार pillbox भरें\n'
            '• खुराक और समय के साथ लिखित दवा सूची रखें\n'
            '• सूची एक परिवार के सदस्य के साथ साझा करें\n'
            '• हर क्लिनिक विज़िट पर दवा सूची की एक प्रति ले जाएं',
      ),
    ],
    tasksEn: [
      'Take all prescribed medicines today (on time)',
      'Set phone alarm for tomorrow\'s medication',
      'Check medicine expiry dates',
      'Fill your pillbox for the week',
      'Report any side effects to your doctor',
    ],
    tasksHi: [
      'आज सभी निर्धारित दवाएं लें (समय पर)',
      'कल की दवा के लिए फोन अलार्म सेट करें',
      'दवा की एक्सपायरी डेट जांचें',
      'सप्ताह के लिए pillbox भरें',
      'कोई भी दुष्प्रभाव अपने डॉक्टर को बताएं',
    ],
  ),
];
