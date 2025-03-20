List<String> cropList = [
  'Wheat',
  'Rice',
  'Onion',
  'Tomato',
];

List<String> expenseOptions = [
  'Fertilizers',
  'Seeds',
  'Labour',
  'Travel',
];

List<String> benefitOptions = [
  'Total',
];

List<double> wheatPredictions = [
  2875.900326,
  2809.192750,
  2763.218781,
  2851.913308,
  2892.356145,
  2805.358936,
  2798.054408,
  2785.341543,
  2857.749830,
  2919.688312,
  3009.504767,
  2927.830392,
];
List<double> ricePredictions = [
  2607.729892,
  2688.223226,
  2743.109157,
  2764.185380,
  2769.433999,
  2758.508009,
  2742.050273,
  2744.839257,
  2787.445206,
  2778.403817,
  2784.982274,
  2776.698230
];

List<double> onionPredictions = [
  3628.244716,
  3302.597042,
  3148.859543,
  2956.224486,
  3098.070948,
  3659.031498,
  3853.561597,
  4173.886256,
  5100.606351,
  5420.038166,
  5725.500436,
  4836.625761
];

List<double> tomatoPredictions = [
  1450.013926,
  1521.511380,
  1564.103978,
  1488.230878,
  1757.730684,
  2643.560936,
  3227.482254,
  3393.425389,
  1860.650249,
  1952.913038,
  2081.383495,
  1803.138765
];

List<String> months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

List<Map> schemeList = [
  {
    "Title": "Agriculture Infrastructure Fund",
    "Link": "http://agriinfra.dac.gov.in/"
  },
  {
    "Title": "PM-Kisan Samman Nidhi",
    "Link": "https://pmkisan.gov.in/",
  },
  {
    "Title": "ATMA",
    "Link": "https://extensionreforms.da.gov.in/DashBoard_Statusatma.aspx"
  },
  {
    "Title": "AGMARKNET",
    "Link": "http://agmarknet.gov.in/PriceAndArrivals/arrivals1.aspx"
  },
  {
    "Title": "Horticulture",
    "Link": "http://midh.gov.in/nhmapplication/feedback/midhKPI.aspx"
  },
  {
    "Title": "Online Pesticide Registration",
    "Link": "https://agriwelfare.gov.in//Documents/Pesticides_Registration.pdf"
  },
  {
    "Title": "Plant Quarantine Clearance",
    "Link": "https://pqms.cgg.gov.in/pqms-angular/home"
  },
  {"Title": "DBT in Agriculture", "Link": "https://www.dbtdacfw.gov.in/"},
  {
    "Title": "Pradhanmantri Krishi Sinchayee Yojana",
    "Link": "https://pmksy.gov.in/mis/frmDashboard.aspx"
  },
  {
    "Title": "Kisan Call Center",
    "Link": "https://mkisan.gov.in/Home/KCCDashboard"
  },
  {"Title": "mKisan", "Link": "https://mkisan.gov.in/"},
  {"Title": "Jaivik Kheti", "Link": "https://pgsindia-ncof.gov.in/home.aspx"},
  {"Title": "e-Nam", "Link": "https://enam.gov.in/"},
  {"Title": "Soil Health Card", "Link": "https://soilhealth.dac.gov.in/"},
  {
    "Title": "Pradhan Mantri Fasal Bima Yojana",
    "Link": "https://pmfby.gov.in/ext/rpt/ssfr_17"
  },
  {
    "Title": "कृषी योजना",
    "Link": "https://www.manage.gov.in/fpoacademy/SGSchemes/maharashtra.pdf"
  },
  {"Title": "राष्ट्रीय कृषी बाजार - eNAM", "Link": "https://enam.gov.in/web/"},
  {
    "Title": "प्रधानमंत्री शेतकरी सन्मान निधी योजना",
    "Link": "https://www.pmkisan.gov.in/Grievance.aspx"
  },
  {
    "Title": "कृषी तारण कर्ज योजना",
    "Link": "https://www.msamb.com/Schemes/PledgeFinance"
  },
  {
    "Title": "सागरी मार्गाने कृषी उत्पादनाच्या निर्यातीसाठी अनुदान योजना",
    "Link": "https://www.msamb.com/Schemes/ExportScheme"
  },
  {
    "Title": "फळे आणि धान्य महोत्सव अनुदान योजना",
    "Link": "https://www.msamb.com/Schemes/Fruitsandgrainfestival"
  },
  {
    "Title": "रस्त्याद्वारे मालवाहतूक अनुदान योजना",
    "Link": "https://www.msamb.com/Schemes/RoadTrasport"
  }
];

List<double> getPredictions(String crop) {
  switch (crop) {
    case 'Wheat':
      return wheatPredictions;
    case 'Rice':
      return ricePredictions;
    case 'Onion':
      return onionPredictions;
    case 'Tomato':
      return tomatoPredictions;
    default:
      return wheatPredictions;
  }
}
