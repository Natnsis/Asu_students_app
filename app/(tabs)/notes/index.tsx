import { View, Text, TextInput, StyleSheet, TouchableOpacity } from 'react-native';
import React from 'react';
import { Link } from 'expo-router';

export default function Index() {
  return (
    <View style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerText}>Notes</Text>
        <Text style={styles.description}>
          Add notes you need to remember or share with others.
          {'\n'}You can also add a title to your note.
        </Text>
      </View>

      {/* Title Input */}
      <TextInput
        style={styles.titleInput}
        placeholder="Enter Title"
        placeholderTextColor="#888"
      />

      {/* Text Area for Larger Info */}
      <TextInput
        style={styles.textArea}
        placeholder="Enter detailed information..."
        placeholderTextColor="#888"
        multiline
        numberOfLines={6}
      />

      <View style={styles.buttonContainer}>
        <TouchableOpacity style={styles.button}>
          <Text style={styles.buttonText}>
            Save 
          </Text>
        </TouchableOpacity>

        <TouchableOpacity style={styles.button}>
          <Text style={styles.buttonText}>
            Cancel
          </Text>
        </TouchableOpacity>
      </View>

      <TouchableOpacity style={styles.buttonShow}>
        <Link href="(inner)/notes" style={styles.buttonText}>
          View all notes
        </Link>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16,
    backgroundColor: 'white',
  },
  header: {
    marginBottom: 20,
  },
  headerText: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 8,
  },
  description: {
    fontSize: 16,
    color: '#555',
    textAlign:"center"
  },
  titleInput: {
    height: 40,
    borderColor: '#ccc',
    borderWidth: 1,
    borderRadius: 8,
    paddingHorizontal: 10,
    marginBottom: 16,
    backgroundColor: '#f9f9f9',
  },
  textArea: {
    borderColor: '#ccc',
    borderWidth: 1,
    borderRadius: 8,
    paddingHorizontal: 10,
    paddingVertical: 10,
    textAlignVertical: 'top', 
    backgroundColor: '#f9f9f9',
    height: 200, 
  },
  buttonContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginTop: 20,
    alignItems:"center"
  },
  button: {
    backgroundColor: '#007BFF',
    padding: 12,
    borderRadius: 8,
    width: '48%',
    alignItems: 'center',
  },
  buttonText:{
    color: 'white',
    fontSize: 16,
    fontWeight: 'bold',
  },
  buttonShow:{
    backgroundColor: '#007BFF',
    padding: 12,
    borderRadius: 8,
    width: '100%',
    alignItems: 'center',
    marginTop: 10,
  }
});