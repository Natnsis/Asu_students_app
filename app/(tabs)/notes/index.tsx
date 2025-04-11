import React, { useState, useEffect } from 'react';
import { View, Text, TextInput, StyleSheet, TouchableOpacity, Alert } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { Link } from 'expo-router';

export default function Notes() {
  const [title, setTitle] = useState('');
  const [content, setContent] = useState('');
  const [notes, setNotes] = useState([]);

  // Load notes from AsyncStorage on component mount
  useEffect(() => {
    const loadNotes = async () => {
      try {
        const storedNotes = await AsyncStorage.getItem('notes');
        if (storedNotes) {
          setNotes(JSON.parse(storedNotes));
        }
      } catch (error) {
        console.error('Error loading notes:', error);
      }
    };

    loadNotes();
  }, []);

  // Save a new note
  const saveNote = async () => {
    if (!title.trim() || !content.trim()) {
      Alert.alert('Error', 'Both title and content are required.');
      return;
    }

    const newNote = { id: Date.now(), title, content };
    const updatedNotes = [...notes, newNote];
    setNotes(updatedNotes);

    try {
      await AsyncStorage.setItem('notes', JSON.stringify(updatedNotes));
      Alert.alert('Success', 'Note saved successfully!');
      setTitle('');
      setContent('');
    } catch (error) {
      console.error('Error saving note:', error);
    }
  };

  // Clear the input fields
  const clearInputs = () => {
    setTitle('');
    setContent('');
  };

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
        value={title}
        onChangeText={setTitle}
      />

      {/* Text Area for Larger Info */}
      <TextInput
        style={styles.textArea}
        placeholder="Enter detailed information..."
        placeholderTextColor="#888"
        multiline
        numberOfLines={6}
        value={content}
        onChangeText={setContent}
      />

      {/* Buttons */}
      <View style={styles.buttonContainer}>
        <TouchableOpacity style={styles.button} onPress={saveNote}>
          <Text style={styles.buttonText}>Save</Text>
        </TouchableOpacity>

        <TouchableOpacity style={styles.button} onPress={clearInputs}>
          <Text style={styles.buttonText}>Cancel</Text>
        </TouchableOpacity>
      </View>

      {/* View All Notes Button */}
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
    textAlign: 'center',
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
    alignItems: 'center',
  },
  button: {
    backgroundColor: '#007BFF',
    padding: 12,
    borderRadius: 8,
    width: '48%',
    alignItems: 'center',
  },
  buttonText: {
    color: 'white',
    fontSize: 16,
    fontWeight: 'bold',
  },
  buttonShow: {
    backgroundColor: '#007BFF',
    padding: 12,
    borderRadius: 8,
    width: '100%',
    alignItems: 'center',
    marginTop: 10,
  },
});