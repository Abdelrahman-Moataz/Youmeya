import 'package:youmeya/consent/consent.dart';

Widget basketCard ({context1, context2}){
  final w = MediaQuery.of(context1).size.width;
  final h = MediaQuery.of(context2).size.height;
  return  Column(
    children: [
      SizedBox(
        height: h * 0.12,
        child: Card(
          shadowColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(shirt),
                const  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("T-shirt"),
                    Text("0.25 EGP"),
                  ],
                ),

                InkWell(
                  onTap: (){},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: bottom,
                    ),
                    child:  const Icon(Icons.add,color: whiteColor,),
                  ),
                ),

                const Text("5"),

                InkWell(
                  onTap: (){},
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: borderColor)
                    ),
                    child:  const Icon(Icons.minimize,),
                  ),
                ),

                const Text("52 EGP"),
              ],
            ),
          ),
        ),
      ),

    ],
  );
}