import 'package:youmeya/consent/consent.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore fireStore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

//collections
const userCollection = "users";
const productsCollection = "product";
const locationCollection = "location";
const cartCollection = "cart";
const chatsCollection = 'chats';
const messagesCollection = 'messages';
const ordersCollection = "orders";
const productGroupInfoCollection = "productsGroupInfo";
const serviceDetails = "service_details";


