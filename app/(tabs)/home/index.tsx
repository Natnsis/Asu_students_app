import { Text, View, StyleSheet, ScrollView, Image, TouchableOpacity, Linking, Alert } from "react-native";
import { MaterialIcons } from '@expo/vector-icons'; 
import * as Clipboard from 'expo-clipboard'; 
import { Link } from "expo-router";

export default function Index() {
  // Telegram group link
  const telegramGroupLink = "https://t.me/letsBuildStuff";
  const telegramGroupName = "letsBuildStuff"; // Group name as fallback

  // Function to open the Telegram group
  const openTelegramGroup = () => {
    Linking.openURL(telegramGroupLink).catch((err) =>
      console.error("Failed to open Telegram group:", err)
    );
  };

  // Function to copy the link to the clipboard
  const copyToClipboard = async () => {
    await Clipboard.setStringAsync(telegramGroupLink);
    Alert.alert("Copied", "Telegram group link copied to clipboard!");
  };

  return (
    <ScrollView style={styles.container}>
      <Image
        source={require('../../../assets/images/icon.png')} 
        style={styles.image}
      />
      <View style={styles.content}>
        <Text  className="text-4xl text-blue-500">Welcome to ASA Students app</Text>
        <Text style={styles.body}>
          Checkout all the Available features and services this app can provide.
        </Text>

        {/* Buttons to go straight to inner links */}
        <TouchableOpacity style={styles.greenButton}>
          <Link href="../(inner)/notes" style={styles.buttonText}>Notes</Link>
        </TouchableOpacity>

        <TouchableOpacity style={styles.greenButton}>
          <Link href="../(inner)/tableCafe" style={styles.buttonText}>Cafe Schedule</Link>
        </TouchableOpacity>

        <TouchableOpacity style={styles.greenButton}>
          <Link href="../(inner)/tableClass" style={styles.buttonText}>Class Schedule</Link>
        </TouchableOpacity>

        {/* tabs description content */}
        <View style={styles.tabsInfoContainer}>

          {/* defining explore tab */}
          <View style={styles.tabs}>
            <Text style={styles.tabTitle}>
              Explore
            </Text>
            <Text style={styles.tabDescription}>
              This tab provides you with all the information about commonly given services by the campus. Such as: Cafeteria🥗, Library📖, NonCafe🍕, Shop and many more.
            </Text>
          </View>

          {/* defining notes tab */}
          <View style={styles.tabs}>
            <Text style={styles.tabTitle}>
              Notes
            </Text>
            <Text style={styles.tabDescription}>
              This tab allows you to store notes 📒 and other important information, its easy and fast to use✨.
            </Text>
          </View>

          {/* defining community tab */}
          <View style={styles.tabs}>
            <Text style={styles.tabTitle}>
              Community
            </Text>
            <Text style={styles.tabDescription}>
              This tab gives you an opportunity to socialize🤳 and join groups thats support your ideas🙌 and belief, contains telegram groups👋 and other related links that might assist you to save time and interact with your surrounding🤝.
            </Text>
          </View>

          {/* Seek Programmers */}
          <View style={styles.tabDescription}>
            <Image 
                source={require('../../../assets/images/icon.png')} 
                style={styles.innerImage}
              />
            <Text style={styles.level}>
              <MaterialIcons name="star" size={15} color="red" />
              Are you interested in developing similar apps?
            </Text >
            <Text style={styles.level}>
            <MaterialIcons name="star" size={15} color="red" />
              Are you in CS, IS, IT and any other related department?
            </Text>
            <Text style={styles.level}>
            <MaterialIcons name="star" size={15} color="red" />
              Do you want to join a certain club composed of people with similar ideas?
            </Text>
            <TouchableOpacity style={styles.buttonGrp} onPress={openTelegramGroup}>
              <Text style={styles.inText}>
                Join us on Telegram 
              </Text>
            </TouchableOpacity>

            {/* Display the Telegram group link or name */}
            <View style={styles.groupInfoContainer}>
              <Text style={styles.groupInfo}>
                Or copy this link: <Text style={styles.groupLink}>{telegramGroupLink}</Text>
              </Text>
              <TouchableOpacity onPress={copyToClipboard}>
                <MaterialIcons name="content-copy" size={20} color="blue" />
              </TouchableOpacity>
            </View>
          </View>
        
        {/* feedback and thanks */}
        <View style={styles.footer}>
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
  innerImage:{
    width: "100%",
    height: 100,
    resizeMode: "cover",
    borderRadius:25,
    marginBottom:10
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
  greenButton: {
    backgroundColor: 'green',
    padding: 12,
    borderRadius: 8,
    marginVertical: 10,
    alignItems: 'center',
  },
  buttonText: {
    color: 'white',
    fontSize: 16,
    fontWeight: 'bold',
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
  footer:{
    marginTop:20
  },
  level:{
    color:"green",
    fontSize:16
  },
  buttonGrp:{
    backgroundColor: '#007BFF',
    padding: 12,
    borderRadius: 8,
    width: '100%',
    alignItems: 'center',
    marginTop: 10,
  },
  inText:{
    color: 'white',
    fontSize: 16,
    fontWeight: 'bold',
  },
  groupInfoContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    marginTop: 10,
  },
  groupInfo: {
    fontSize: 14,
    color: '#555',
    textAlign: 'center',
    marginRight: 8,
  },
  groupLink: {
    fontWeight: 'bold',
    color: 'blue',
  },
});