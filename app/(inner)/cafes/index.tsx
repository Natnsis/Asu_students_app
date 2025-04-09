import { StyleSheet, Text, View, Image, ScrollView } from 'react-native';
import React from 'react';

export default function cafes() {
  const cafes = [
    {
      name: 'Main Cafe',
      time: 'Opens: 6:00 AM | Closes: 9:00 PM',
      foods: [
        { name: 'Pasta', price: '$5.00' },
        { name: 'Burger', price: '$3.50' },
        { name: 'Coffee', price: '$1.50' },
      ],
    },
    {
      name: 'Science Cafe',
      time: 'Opens: 7:00 AM | Closes: 8:00 PM',
      foods: [
        { name: 'Pizza', price: '$6.00' },
        { name: 'Sandwich', price: '$4.00' },
        { name: 'Tea', price: '$1.00' },
      ],
    },
    {
      name: 'Library Cafe',
      time: 'Opens: 8:00 AM | Closes: 10:00 PM',
      foods: [
        { name: 'Salad', price: '$4.50' },
        { name: 'Juice', price: '$2.50' },
        { name: 'Cake', price: '$3.00' },
      ],
    },
  ];

  return (
    <ScrollView style={styles.container}>
      {cafes.map((cafe, index) => (
        <View key={index} style={styles.cafeContainer}>
          {/* Images */}
          <View style={styles.imageContainer}>
            <Image style={styles.image} source={require('../../../assets/images/favicon.png')} />
            <Image style={styles.image} source={require('../../../assets/images/favicon.png')} />
          </View>

          {/* Cafe Name */}
          <Text style={styles.cafeName}>{cafe.name}</Text>

          {/* Opening and Closing Times */}
          <Text style={styles.time}>{cafe.time}</Text>

          {/* Foods and Prices */}
          <View style={styles.foodList}>
            {cafe.foods.map((food, idx) => (
              <Text key={idx} style={styles.foodItem}>
                {food.name} - {food.price}
              </Text>
            ))}
          </View>
        </View>
      ))}
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'white',
    padding: 16,
  },
  cafeContainer: {
    marginBottom: 24,
    padding: 16,
    backgroundColor: '#f9f9f9',
    borderRadius: 8,
    borderWidth: 1,
    borderColor: '#ddd',
  },
  imageContainer: {
    flexDirection: 'row',
    marginBottom: 16,
    justifyContent: 'center',
  },
  image: {
    width: '45%', 
    height: 150, 
    borderRadius: 8,
    resizeMode: 'cover',
    marginRight: 10, 
  },
  cafeName: {
    fontSize: 20,
    fontWeight: 'bold',
    textAlign: 'center',
    marginBottom: 8,
  },
  time: {
    fontSize: 14,
    color: '#555',
    textAlign: 'center',
    marginBottom: 16,
  },
  foodList: {
    marginTop: 8,
  },
  foodItem: {
    fontSize: 16,
    color: '#333',
    marginBottom: 4,
  },
});