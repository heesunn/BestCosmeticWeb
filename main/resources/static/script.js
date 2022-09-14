// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "",
  authDomain: "",
  projectId: "",
  storageBucket: "",
  messagingSenderId: "",
  appId: ""
};		  

	firebase.initializeApp(firebaseConfig);

// also store files path in localstorage or in database for further use
if(!localStorage.getItem("uploaded-metadata")){
    var metadata = '[]';
    localStorage.setItem('uploaded-metadata', metadata)
}
    