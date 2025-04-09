import { Text, View, StyleSheet, ScrollView, Image } from "react-native";

export default function Index() {

  //contents for tabs description
  const contents = [
    {
      title: "Explore",
      description:
        "This tab provides you with all the information about commonly given services by the campus. Such as: Cafeteria🥗, Library📖, NonCafe🍕, Shop and many more.",
    },
    {
      title: "Notes",
      description:
        "This tab allows you to store notes 📒 and other important information, its easy and fast to use✨.",
    },
    {
      title: "Community",
      description:
        "This tab gives you an opportunity to socialize🤳 and join groups thats support your ideas🙌 and belief, contains telegram groups👋 and other related links that might assist you to save time and interact with your surrounding🤝.",
    },
    
  ]

  return (
    <ScrollView style={styles.container}>
      <Image
        source={require('../../../assets/images/icon.png')} 
        style={styles.image}
      />
      <View style={styles.content}>
        <Text style={styles.title}>Welcome to NSB app </Text>
        <Text style={styles.body}>
          Checkout all the Available features and services this app can provide.
        </Text>

        {/* tabs description content */}
        <View style={styles.tabsInfoContainer}>

          {/* defining explore tab */}
          <View style={styles.tabs}>
            <Text style={styles.tabTitle}>
              {contents[0].title}
            </Text>
            <Text style={styles.tabDescription}>
              {contents[0].description}
            </Text>
          </View>

          {/* defining notes tab */}
          <View style={styles.tabs}>
            <Text style={styles.tabTitle}>
              {contents[1].title}
            </Text>
            <Text style={styles.tabDescription}>
              {contents[1].description}
            </Text>
          </View>

          {/* defining community tab */}
          <View style={styles.tabs}>
            <Text style={styles.tabTitle}>
              {contents[2].title}
            </Text>
            <Text style={styles.tabDescription}>
              {contents[2].description}
            </Text>
          </View>
        
        {/* feedback and thanks */}
        <View>
          <Text style={styles.footerData}>
            Thanks for using my app!😄 contact me if you encounter any issues or feedback am open to chat.
          </Text>
        </View>

        </View>
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "white",
  },
  image: {
    width: "100%",
    height: 200,
    resizeMode: "cover",
  },
  content: {
    padding: 16,
  },
  title: {
    textAlign: "center",
    fontSize: 30,
    fontWeight: "bold",
    marginBottom: 8,
    color:"blue"
  },
  body: {
    fontSize: 16,
    textAlign: "center",
    color:"#A9A9A9"
  },
  
  tabsInfoContainer:{
    marginTop:15,
    padding:5
  },
  tabs:{
    marginBottom:20,
    padding:5,
  },
  tabTitle:{
    textAlign:"center",
    fontSize:20,
    fontFamily:"Noto Serif",
    color:"green",
    fontWeight:"medium"
    
  },
  tabDescription:{
    backgroundColor:"#F0F0F0",
    padding:12,
    borderRadius:12,
    
  },
  footerData:{
    textAlign:"center",
    fontSize:10,

  },


  
});