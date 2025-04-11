import { ScrollView, View, Text, StyleSheet, Image, TouchableOpacity } from 'react-native';
import React from 'react';
import { MaterialIcons } from '@expo/vector-icons'; // Import MaterialIcons for icons
import { Link } from 'expo-router';

export default function Index() {
  return (
    <ScrollView style={styles.container}>
      {/* Header with Explore */}
      <View style={styles.header}>
        <Text style={styles.exploreText}>Explore</Text>
      </View>

      {/* all the rest of the content */}
      <View>
        {/* cafe content */}
        <View style={styles.contentContainer}>
          <Text style={styles.title}>Main Cafe</Text>
          <Image 
            source={require('../../../assets/images/favicon.png')}
            style={styles.image} 
          />

          {/* foodTime */}
          <View style={{ marginTop: 10 }}>
            <Text style={{ fontSize: 16, fontWeight: 'bold' }}>Food Time</Text>

            {/* breakfast */}
            <View style={styles.infoRow}>
              <MaterialIcons name="restaurant" size={20} color="black" />
              <Text style={styles.infoText}>Breakfast:</Text>
            </View>
            <View style={styles.infoRow}>
              <MaterialIcons name="schedule" size={20} color="gray" />
              <Text style={styles.timeText}>12:00am-2:00am Lt</Text>
            </View>

            {/* lunch */}
            <View style={styles.infoRow}>
              <MaterialIcons name="restaurant" size={20} color="black" />
              <Text style={styles.infoText}>Lunch:</Text>
            </View>
            <View style={styles.infoRow}>
              <MaterialIcons name="schedule" size={20} color="gray" />
              <Text style={styles.timeText}>5:30am-7:00am Lt</Text>
            </View>

            {/* dinner */}
            <View style={styles.infoRow}>
              <MaterialIcons name="restaurant" size={20} color="black" />
              <Text style={styles.infoText}>Dinner:</Text>
            </View>
            <View style={styles.infoRow}>
              <MaterialIcons name="schedule" size={20} color="gray" />
              <Text style={styles.timeText}>11:30am-1:00pm Lt</Text>
            </View>
          </View>

          {/* schedule of food cafe */}
          <View>
            <TouchableOpacity style={styles.button}>
              <Link href="(inner)/schedule" style={styles.innerButton}>Check food Schedule</Link>
            </TouchableOpacity>
          </View>
        </View>

        {/* library content */}
        <View style={styles.contentContainer}>
          <Text style={styles.title}>Library</Text>
          <Image 
            source={require('../../../assets/images/favicon.png')}
            style={styles.image} 
          />
          <View style={styles.infoRow}>
            <MaterialIcons name="local-library" size={20} color="black" />
            <Text style={styles.infoText}>Libraries are open 24/7</Text>
          </View>

          <TouchableOpacity style={styles.button}>
            <Link href="(inner)/libraries" style={styles.innerButton}>
              Check Resources
            </Link>
          </TouchableOpacity>
        </View>

        {/* noncafe content */}
        <View style={styles.contentContainer}>
          <Text style={styles.title}>Non-Cafe</Text>
          <Image
            source={require('../../../assets/images/favicon.png')}
            style={styles.image}
          />
          <Text style={{ fontSize: 16, fontWeight: 'bold', marginTop:10, marginBottom:10 }}>Opening and Closing: time</Text>
          <View style={styles.infoRow}>
              <MaterialIcons name="restaurant" size={20} color="black" />
              <Text style={styles.infoText}>Opens At:</Text>
            </View>
            <View style={styles.infoRow}>
              <MaterialIcons name="schedule" size={20} color="gray" />
              <Text style={styles.timeText}>2:30Lt</Text>
          </View>
          <View style={styles.infoRow}>
              <MaterialIcons name="restaurant" size={20} color="black" />
              <Text style={styles.infoText}>Closes At:</Text>
            </View>
            <View style={styles.infoRow}>
              <MaterialIcons name="schedule" size={20} color="gray" />
              <Text style={styles.timeText}>3:00Lt</Text>
          </View>
          <TouchableOpacity style={styles.button}>
            <Link href="(inner)/cafes" style={styles.innerButton}>Check Available Cafes</Link>
          </TouchableOpacity>
        </View>
        
        {/* shop content */}
        <View style={styles.contentContainer}>
          <Text style={styles.title}>Shop</Text>
          <Image 
            source={require('../../../assets/images/favicon.png')}
            style={styles.image}
          />
          <Text style={styles.shop}>
            This shop is closest to Social science students! mostly open.
          </Text>
          <Image
            source={require('../../../assets/images/favicon.png')}
            style={styles.image}
          />
          <Text style={styles.shop}>
            this shop is closest to Natural science students! not much reliable.
          </Text>
        </View>

        {/* barber shop  */}
        <View style={styles.contentContainer}>
          <Text style={styles.title}>Barber Shop </Text>
          <View>
            <Image 
              source={require('../../../assets/images/favicon.png')}
              style={styles.image} 
            />
            <View style={styles.infoRow2}>
              <Text>
                Price for hair cut 
              </Text>
              <Text style={styles.money}>
                50Birr
              </Text>
              
            </View>
            <View style={styles.infoRow2}>
              <Text>
                Price for shaving   
              </Text>
              <Text style={styles.money}>
                30Birr
              </Text>
            </View>
          </View>
        </View>

      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'white',
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 10,
  },
  exploreText: {
    fontSize: 20,
    fontWeight: 'bold',
    marginRight: 10,
  },
  contentContainer: {
    padding: 10,
    marginBottom: 10,
  },
  image: {
    width: "100%",
    height: 200,
    resizeMode: "cover",
  },
  infoRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: 5,
  },
  infoText: {
    fontSize: 16,
    marginLeft: 5,
  },
  timeText: {
    fontSize: 14,
    marginLeft: 5,
    color: 'gray', 
  },
  button: {
    backgroundColor: '#007BFF',
    padding: 10,
    borderRadius: 5,
    alignItems: 'center',
    marginTop: 10,
    justifyContent: 'center'
  },
  innerButton: {
    color: 'white',
    fontSize: 16,
    width: "100%",
    textAlign: 'center',
  },
  title:{
    textAlign:"center",
    fontSize:20,
    fontWeight:"bold",
    marginBottom:10
  },
  shop:{
    fontSize:15,
    marginTop:5,
    marginBottom:15,
    textAlign:"center",
    fontStyle:"italic"
  },
  money:{
    color:"green"
  },
  infoRow2: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: 10,
    justifyContent: 'space-between',
    marginBottom:10
  }
});