
// Initialize Firebase
const config = {
  apiKey: "AIzaSyCrvgYgeqw7HfCi94IRuBscm0xk-X5c8w0",
  authDomain: "works-83875.firebaseapp.com",
  databaseURL: "https://works-83875.firebaseio.com",
  projectId: "works-83875",
  storageBucket: "works-83875.appspot.com",
  messagingSenderId: "968832613657"
};
firebase.initializeApp(config);

// Check Real Time Data
// if you can't see real time data,
// change rules.child '.read' & 'withe' : all -> true
// Originally, we need auth keys.
const project_title = document.getElementById('project_title');
const dbRef = firebase.database().ref().child('title');
dbRef.on('value', snap => project_title.innerText = snap.val());

const uploader =  document.getElementById('uploader');
const fileButton = document.getElementById('fileButton');

// Listen for file selection : 파일 선택된 것을 알게 해줘야한다.
fileButton.addEventListener('change', function(e){
  // Get file : 파일을 가져온다.
  const file = e.target.files[0];
  // Create a storage ref : 업로드시 사용할 수 있는 저장소 생성
  const storageRef = firebase.storage().ref('test/' + file.name);
  // Upload file
  const task = storageRef.put(file);
  // Update progress bar
  task.on('state_changed',

    function progress(snapshot){
      const percentage = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      uploader.value = percentage;
    },
    function error(err){

    },
    function complete(){

    }

  )
  });
