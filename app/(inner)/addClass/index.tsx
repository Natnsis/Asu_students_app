import React, { useState, useEffect } from 'react';
import { View, Text, TextInput, TouchableOpacity, StyleSheet, ScrollView, Alert } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';

export default function AddClass() {
  const [classSchedule, setClassSchedule] = useState([]);
  const [newClass, setNewClass] = useState({ day: '', subject: '', time: '', room: '' });

  // Fetch existing class schedule from AsyncStorage
  useEffect(() => {
    const fetchClassSchedule = async () => {
      try {
        const storedClasses = await AsyncStorage.getItem('classSchedules');
        if (storedClasses) {
          setClassSchedule(JSON.parse(storedClasses));
        }
      } catch (error) {
        console.error('Error fetching class schedule:', error);
      }
    };

    fetchClassSchedule();
  }, []);

  // Save the updated class schedule to AsyncStorage
  const saveClassSchedule = async () => {
    if (!newClass.day || !newClass.subject || !newClass.time || !newClass.room) {
      Alert.alert('Error', 'Please fill in all fields before saving.');
      return;
    }

    const updatedSchedule = [...classSchedule, { ...newClass, id: Date.now() }];
    try {
      await AsyncStorage.setItem('classSchedules', JSON.stringify(updatedSchedule));
      setClassSchedule(updatedSchedule);
      setNewClass({ day: '', subject: '', time: '', room: '' }); // Reset input fields
      Alert.alert('Success', 'Class schedule saved successfully!');
    } catch (error) {
      console.error('Error saving class schedule:', error);
      Alert.alert('Error', 'Failed to save class schedule.');
    }
  };

  // Delete a class schedule
  const deleteClassSchedule = async (id) => {
    const updatedSchedule = classSchedule.filter((item) => item.id !== id);
    try {
      await AsyncStorage.setItem('classSchedules', JSON.stringify(updatedSchedule));
      setClassSchedule(updatedSchedule);
      Alert.alert('Success', 'Class schedule deleted successfully!');
    } catch (error) {
      console.error('Error deleting class schedule:', error);
      Alert.alert('Error', 'Failed to delete class schedule.');
    }
  };

  return (
    <ScrollView style={styles.container}>
      <Text style={styles.title}>Add Class Schedule</Text>

      {/* Input Fields */}
      <View style={styles.inputContainer}>
        <Text style={styles.label}>Day</Text>
        <TextInput
          style={styles.input}
          placeholder="Enter day (e.g., Monday)"
          value={newClass.day}
          onChangeText={(text) => setNewClass({ ...newClass, day: text })}
        />

        <Text style={styles.label}>Subject</Text>
        <TextInput
          style={styles.input}
          placeholder="Enter subject (e.g., Math)"
          value={newClass.subject}
          onChangeText={(text) => setNewClass({ ...newClass, subject: text })}
        />

        <Text style={styles.label}>Time</Text>
        <TextInput
          style={styles.input}
          placeholder="Enter time (e.g., 10:00 AM)"
          value={newClass.time}
          onChangeText={(text) => setNewClass({ ...newClass, time: text })}
        />

        <Text style={styles.label}>Room</Text>
        <TextInput
          style={styles.input}
          placeholder="Enter room (e.g., Room 101)"
          value={newClass.room}
          onChangeText={(text) => setNewClass({ ...newClass, room: text })}
        />
      </View>

      {/* Save Button */}
      <TouchableOpacity style={styles.saveButton} onPress={saveClassSchedule}>
        <Text style={styles.saveButtonText}>Save Class</Text>
      </TouchableOpacity>

      {/* Existing Schedule */}
      <Text style={styles.subtitle}>Existing Class Schedule</Text>
      {classSchedule.length > 0 ? (
        classSchedule.map((item) => (
          <View key={item.id} style={styles.scheduleItem}>
            <Text style={styles.scheduleText}>
              {item.day} - {item.subject} at {item.time} in {item.room}
            </Text>
            <TouchableOpacity
              style={styles.deleteButton}
              onPress={() => deleteClassSchedule(item.id)}
            >
              <Text style={styles.deleteButtonText}>Delete</Text>
            </TouchableOpacity>
          </View>
        ))
      ) : (
        <Text style={styles.noScheduleText}>No class schedule available.</Text>
      )}
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'white',
    padding: 16,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    textAlign: 'center',
    marginBottom: 16,
  },
  inputContainer: {
    marginBottom: 16,
  },
  label: {
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 8,
  },
  input: {
    borderWidth: 1,
    borderColor: '#ccc',
    borderRadius: 8,
    padding: 12,
    marginBottom: 16,
    backgroundColor: '#f9f9f9',
  },
  saveButton: {
    backgroundColor: 'green',
    padding: 12,
    borderRadius: 8,
    alignItems: 'center',
    marginBottom: 16,
  },
  saveButtonText: {
    color: 'white',
    fontSize: 16,
    fontWeight: 'bold',
  },
  subtitle: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 8,
  },
  scheduleItem: {
    padding: 12,
    borderWidth: 1,
    borderColor: '#ccc',
    borderRadius: 8,
    marginBottom: 8,
    backgroundColor: '#f9f9f9',
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  scheduleText: {
    fontSize: 16,
    flex: 1,
  },
  deleteButton: {
    backgroundColor: 'red',
    padding: 8,
    borderRadius: 8,
    marginLeft: 8,
  },
  deleteButtonText: {
    color: 'white',
    fontSize: 14,
    fontWeight: 'bold',
  },
  noScheduleText: {
    fontSize: 16,
    textAlign: 'center',
    color: '#888',
  },
});