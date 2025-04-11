import { View, Text, StyleSheet, FlatList, TouchableOpacity, Linking, Alert } from 'react-native';
import React from 'react';
import { FontAwesome } from '@expo/vector-icons'; // Use FontAwesome for all icons

export default function Index() {
  const groups = [
    { name: 'Registrar System', description: 'Connect to a local network', icon: 'link', link: 'http://10.16.8.72' },
    { name: 'Assosa university Website', description: 'Business Administration Department', icon: 'link', link: 'https://t.me/asuremedial'},
    { name: 'Assosa Gibi Guaye', description: '4th year orthodox students', icon: 'telegram', link: 'https://asu.edu.et/' },
    { name: 'Asu Students Union', description: 'Computer Science Department', icon: 'telegram', link: 'https://t.me/Asu_StudentUnion' },
    { name: 'Informatics', description: 'IT, IS and Cs Department', icon: 'telegram', link: 'https://t.me/yyyy2346' },
    { name: 'Health Advocates', description: 'Health Science Department', icon: 'telegram', link: 'https://t.me/healthadvocates' },
    { name: 'ASU Muslim Students', description: 'Environmental Science Department', icon: 'telegram', link: 'https://https://t.me/AssosaUniversityMuslimStudents' },
    { name: 'Business Minds', description: 'Business Administration Department', icon: 'telegram', link: 'https://chat.whatsapp.com/businessminds' },
    { name: 'Assosa University', description: 'Business Administration Department', icon: 'telegram', link: 'https://t.me/assosauniversitygroup' },
    { name: 'ASU Remidial Students', description: 'Business Administration Department', icon: 'telegram', link: 'https://t.me/asuremedial'},
  ];

  // Function to open a link
  const openLink = (link) => {
    Linking.openURL(link).catch((err) => {
      console.error("Failed to open link:", err);
      Alert.alert("Error", "Unable to open the link.");
    });
  };

  return (
    <View style={styles.container}>
      {/* Title */}
      <Text style={styles.title}>Socialize and Enjoy</Text>

      {/* Group List */}
      <FlatList
        data={groups}
        keyExtractor={(item, index) => index.toString()}
        renderItem={({ item }) => (
          <View style={styles.groupContainer}>
            <View>
              <Text style={styles.groupName}>{item.name}</Text>
              <Text style={styles.groupDescription}>{item.description}</Text>
            </View>
            <TouchableOpacity onPress={() => openLink(item.link)}>
              {item.icon === 'telegram' && (
                <FontAwesome name="telegram" size={24} color="#0088cc" />
              )}
              {item.icon === 'whatsapp' && (
                <FontAwesome name="whatsapp" size={24} color="#25D366" />
              )}
              {item.icon === 'facebook' && (
                <FontAwesome name="facebook" size={24} color="#4267B2" />
              )}
              {item.icon === 'link' && (
                <FontAwesome name="link" size={24} color="black" />
              )}
            </TouchableOpacity>
          </View>
        )}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16,
    backgroundColor: 'white',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 16,
    textAlign: 'center',
  },
  groupContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 12,
    borderWidth: 1,
    borderColor: '#ccc',
    borderRadius: 8,
    marginBottom: 12,
    backgroundColor: '#f9f9f9',
  },
  groupName: {
    fontSize: 18,
    fontWeight: 'bold',
  },
  groupDescription: {
    fontSize: 14,
    color: '#555',
  },
});