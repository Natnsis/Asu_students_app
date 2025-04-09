import { View, Text, StyleSheet, FlatList, TouchableOpacity } from 'react-native';
import React from 'react';
import { FontAwesome } from '@expo/vector-icons'; // Use FontAwesome for all icons

export default function Index() {
  const groups = [
    { name: 'Tech Enthusiasts', description: 'Computer Science Department', icon: 'telegram' },
    { name: 'Business Minds', description: 'Business Administration Department', icon: 'whatsapp' },
    { name: 'Art Lovers', description: 'Fine Arts Department', icon: 'facebook' },
    { name: 'Health Advocates', description: 'Health Science Department', icon: 'telegram' },
    { name: 'Eco Warriors', description: 'Environmental Science Department', icon: 'whatsapp' },
    { name: 'Registrar System', description: 'Connect to a local network', icon: 'link' },
    { name: 'Orthodox', description: '4th year orthodox students', icon: 'telegram' },
  ];

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
            <TouchableOpacity>
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