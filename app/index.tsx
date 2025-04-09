import { StyleSheet, Text, View, Image } from 'react-native';
import { Link } from 'expo-router' ;
import React from 'react';

const index = () => {
  return (
    <View style={styles.all}>
      <Text style={styles.title}>NSB-APP</Text>
      <View style={styles.imageContainer}>
        <Image
            source={require('../assets/images/icon.png')}
            style={styles.image}
        />
        <Image
            source={require('../assets/images/icon.png')}
            style={styles.image}
        />
      </View>

      <View style={styles.imageContainer}>
        <Image
            source={require('../assets/images/icon.png')}
            style={styles.image}
        />
        <Image
            source={require('../assets/images/icon.png')}
            style={styles.image}
        />
      </View>

      <View style={styles.descriptionContainer}>
        <Text style={styles.description}>
            NSB is a University app built solely to help new students get used to their surrounding and senior students have an easier life with their daily life.
        </Text>
      </View>

    <View style={styles.buttonContainer}>
      <Link href="/(tabs)/home" style={styles.button}>Get In</Link>
    </View>

    <View style={styles.footerContainer}>
        <Text style={styles.footer}>
            &copy; designed and developed by Natnael sisay 
        </Text>
    </View>

    </View>
  )
}

export default index

const styles = StyleSheet.create({
    all:{
        flex:1
    },
    image:{
        width: 100,
        height:100,
        marginRight:"4%",
        marginTop:"10%",
        borderBlockColor:"black",
        borderRadius:12,
        borderWidth:1,
        shadowColor:"light-blue",
        shadowRadius:12,
    },
    imageContainer:{
        flexDirection:"row",
        justifyContent:"space-between",
        paddingHorizontal:"15%"
    },
    title:{
        paddingTop:"3%",
        textAlign:"center",
        fontStyle:"italic",
        fontSize:40,
        fontWeight:"bold"
    },
    description:{
        textAlign:"center",
        color:"#B0B0B0"
    },
    descriptionContainer:{
        paddingHorizontal:7,
        marginTop:12
    },
    button:{
        backgroundColor:"blue",
        color:"white",
        textAlign:"center",
        fontSize:30,
        fontWeight:"bold",
        borderRadius:8,
        paddingVertical:8
    },
    buttonContainer:{
        paddingHorizontal:30,
        marginTop:15
    },
    footer:{
        textAlign:"center",
        fontSize:10
    },
    footerContainer:{
        position:"absolute",
        bottom:0,
        width:"100%"
    }
})