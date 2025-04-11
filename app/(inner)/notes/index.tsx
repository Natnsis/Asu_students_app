import React, { useEffect, useState } from 'react';
import { StyleSheet, Text, View, FlatList, TouchableOpacity, Alert } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { MaterialIcons } from '@expo/vector-icons';

export default function NotesList() {
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

  // Delete a note
  const deleteNote = async (id) => {
    const updatedNotes = notes.filter((note) => note.id !== id);
    setNotes(updatedNotes);

    try {
      await AsyncStorage.setItem('notes', JSON.stringify(updatedNotes));
      Alert.alert('Deleted', 'Note deleted successfully!');
    } catch (error) {
      console.error('Error deleting note:', error);
    }
  };

  return (
    <View style={styles.container}>
      <Text style={styles.headerText}>Your Notes</Text>

      {notes.length === 0 ? (
        <Text style={styles.emptyText}>No notes available. Add some notes!</Text>
      ) : (
        <FlatList
          data={notes}
          keyExtractor={(item) => item.id.toString()}
          renderItem={({ item }) => (
            <View style={styles.noteItem}>
              <View style={styles.noteContent}>
                <Text style={styles.noteTitle}>{item.title}</Text>
                <Text style={styles.noteContentText}>{item.content}</Text>
              </View>
              <TouchableOpacity onPress={() => deleteNote(item.id)}>
                <MaterialIcons name="delete" size={24} color="red" />
              </TouchableOpacity>
            </View>
          )}
        />
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16,
    backgroundColor: 'white',
  },
  headerText: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 16,
    textAlign: 'center',
  },
  emptyText: {
    fontSize: 16,
    color: '#555',
    textAlign: 'center',
    marginTop: 20,
  },
  noteItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    backgroundColor: '#f9f9f9',
    padding: 12,
    borderRadius: 8,
    marginBottom: 10,
    borderWidth: 1,
    borderColor: '#ccc',
  },
  noteContent: {
    flex: 1,
    marginRight: 10,
  },
  noteTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 4,
  },
  noteContentText: {
    fontSize: 14,
    color: '#555',
  },
});