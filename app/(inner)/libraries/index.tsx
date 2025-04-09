import { StyleSheet, Text, ScrollView, View, Image } from 'react-native';
import React from 'react';

export default function index() {
  return (
    <View style={styles.container}>
      <ScrollView contentContainerStyle={styles.scrollContent}>
        <Text style={styles.title}>Libraries</Text>
        <Text style={styles.description}>
          There are two libraries available on the campus. You can choose to visit one according to your department and also the distance from your dorm 👍
        </Text>
        <View style={styles.imageContainer}>
          <Image 
            source={require("../../../assets/images/icon.png")}
            style={styles.image}
          />
          <Image 
            source={require("../../../assets/images/icon.png")}
            style={styles.image}
          />
        </View>
        <View style={styles.libraryInfo}>
          <Text style={styles.libraryTitle}>Natural Science Library</Text>
          <Text style={styles.libraryDescription}>
            This library is located in the Natural Science side of the University. It has a wide range of books and resources related to natural science.
          </Text>
          <Text style={styles.departments}>
            Departments:
            {'\n'}- Health
            {'\n'}- Informatics
            {'\n'}- Natural Science
            {'\n'}- Engineering
            {'\n'}- Natural Science Fresh and Remedial Students
          </Text>
        </View>
        <View style={styles.imageContainer}>
          <Image 
            source={require("../../../assets/images/icon.png")}
            style={styles.image}
          />
          <Image 
            source={require("../../../assets/images/icon.png")}
            style={styles.image}
          />
        </View>
        <View style={styles.libraryInfo}>
          <Text style={styles.libraryTitle}>Social Science Library</Text>
          <Text style={styles.libraryDescription}>
            This library is located near the cafeteria. It has a wide range of books and modules related to social science.
          </Text>
          <Text style={styles.departments}>
            Departments:
            {'\n'}- Law
            {'\n'}- Economics
            {'\n'}- Language
            {'\n'}- Journalism
            {'\n'}- Social Science Fresh and Remedial Students
          </Text>
        </View>
      </ScrollView>
      <Text style={styles.footer}>Pick one based on Your interest!</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'white',
  },
  scrollContent: {
    flexGrow: 1,
    padding: 16,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 16,
    textAlign: 'center',
  },
  description: {
    fontSize: 16,
    color: '#555',
    marginBottom: 16,
    textAlign: 'justify',
  },
  imageContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginVertical: 16,
  },
  image: {
    width: 150,
    height: 150,
    resizeMode: 'cover',
    borderRadius: 8,
  },
  libraryInfo: {
    marginTop: 16,
    padding: 16,
    backgroundColor: '#f9f9f9',
    borderRadius: 8,
    borderWidth: 1,
    borderColor: '#ddd',
  },
  libraryTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 8,
  },
  libraryDescription: {
    fontSize: 16,
    color: '#555',
    marginBottom: 8,
    textAlign: 'justify',
  },
  departments: {
    fontSize: 16,
    color: '#333',
    lineHeight: 24,
  },
  footer: {
    fontSize: 16,
    fontWeight: 'bold',
    textAlign: 'center',
    padding: 16,
    backgroundColor: '#f9f9f9',
  },
});