import React, { useEffect, useState } from 'react';
import { ScrollView, StyleSheet, Text, TextInput, TouchableOpacity, View, Alert } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';

export default function Schedule() {
  const [days, setDays] = useState([]);
  const [editMode, setEditMode] = useState({}); // Track edit mode for each row

  // Initialize default days
  const defaultDays = [
    { id: 1, day: 'Monday', breakfast: '', lunch: '', dinner: '' },
    { id: 2, day: 'Tuesday', breakfast: '', lunch: '', dinner: '' },
    { id: 3, day: 'Wednesday', breakfast: '', lunch: '', dinner: '' },
    { id: 4, day: 'Thursday', breakfast: '', lunch: '', dinner: '' },
    { id: 5, day: 'Friday', breakfast: '', lunch: '', dinner: '' },
    { id: 6, day: 'Saturday', breakfast: '', lunch: '', dinner: '' },
    { id: 7, day: 'Sunday', breakfast: '', lunch: '', dinner: '' },
  ];

  // Load schedules from AsyncStorage
  useEffect(() => {
    const loadSchedules = async () => {
      try {
        const storedDays = await AsyncStorage.getItem('schedules');
        if (storedDays) {
          setDays(JSON.parse(storedDays));
        } else {
          setDays(defaultDays);
          await AsyncStorage.setItem('schedules', JSON.stringify(defaultDays));
        }
      } catch (error) {
        console.error('Error loading schedules:', error);
      }
    };

    loadSchedules();
  }, []);

  // Update the state when the user types in the TextInput
  const handleInputChange = (id, field, value) => {
    const updatedDays = days.map((day) =>
      day.id === id ? { ...day, [field]: value } : day
    );
    setDays(updatedDays);
  };

  // Save the updated schedule to AsyncStorage when the "Save" button is pressed
  const saveSchedule = async () => {
    try {
      await AsyncStorage.setItem('schedules', JSON.stringify(days));
      Alert.alert('Saved', 'Your changes have been saved!');
    } catch (error) {
      console.error('Error saving schedule:', error);
    }
  };

  // Toggle edit mode for a specific row
  const toggleEditMode = (id) => {
    setEditMode((prev) => ({ ...prev, [id]: !prev[id] }));
  };

  return (
    <ScrollView style={styles.main}>
      <View style={styles.head}>
        <Text style={styles.title}>Cafeteria Schedule</Text>
        <Text style={styles.description}>
          Add or update the schedule provided by the university and access it anytime. Press "Edit" to modify and "Save" to save changes 😊
        </Text>
      </View>
      <View style={styles.container}>
        {/* Table Rows */}
        {days.map((day) => (
          <View key={day.id} style={styles.row}>
            <View style={styles.rowContent}>
              {/* Day Column */}
              <Text style={styles.dayColumn}>{day.day}</Text>

              {/* Inputs Column */}
              <View style={styles.foodColumn}>
                <TextInput
                  style={styles.input}
                  value={day.breakfast}
                  placeholder="Breakfast"
                  editable={!!editMode[day.id]} // Only editable in edit mode
                  onChangeText={(text) => handleInputChange(day.id, 'breakfast', text)}
                />
                <TextInput
                  style={styles.input}
                  value={day.lunch}
                  placeholder="Lunch"
                  editable={!!editMode[day.id]} // Only editable in edit mode
                  onChangeText={(text) => handleInputChange(day.id, 'lunch', text)}
                />
                <TextInput
                  style={styles.input}
                  value={day.dinner}
                  placeholder="Dinner"
                  editable={!!editMode[day.id]} // Only editable in edit mode
                  onChangeText={(text) => handleInputChange(day.id, 'dinner', text)}
                />
              </View>
            </View>

            {/* Edit Button */}
            <TouchableOpacity
              style={[styles.editButton, editMode[day.id] ? styles.editButtonActive : null]}
              onPress={() => toggleEditMode(day.id)}
            >
              <Text style={styles.editButtonText}>{editMode[day.id] ? 'Done' : 'Edit'}</Text>
            </TouchableOpacity>
          </View>
        ))}

        {/* Save Button */}
        <TouchableOpacity style={styles.saveButton} onPress={saveSchedule}>
          <Text style={styles.saveButtonText}>Save</Text>
        </TouchableOpacity>
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  main: { backgroundColor: 'white', flex: 1 },
  container: { padding: 16 },
  row: {
    borderBottomWidth: 1,
    paddingVertical: 12,
    marginBottom: 16,
  },
  rowContent: {
    flexDirection: 'row', // Align day and inputs side by side
    justifyContent: 'space-between',
  },
  dayColumn: {
    flex: 1,
    fontWeight: 'bold',
    fontSize: 16,
    textAlign: 'center',
    marginRight: 8,
  },
  foodColumn: {
    flex: 2,
    flexDirection: 'column',
  },
  input: {
    borderRadius: 4,
    borderWidth: 1,
    marginVertical: 4,
    padding: 4,
    backgroundColor: '#f9f9f9',
  },
  saveButton: {
    marginTop: 16,
    backgroundColor: 'green',
    padding: 12,
    borderRadius: 8,
    alignItems: 'center',
  },
  saveButtonText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 16,
  },
  editButton: {
    marginTop: 8,
    backgroundColor: 'red',
    padding: 12,
    borderRadius: 8,
    alignItems: 'center',
    width: '100%', // Full width below the row
  },
  editButtonActive: {
    backgroundColor: 'orange',
  },
  editButtonText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 14,
  },
  head: {
    padding: 10,
  },
  title: {
    textAlign: 'center',
    fontSize: 20,
    fontWeight: 'bold',
  },
  description: {
    textAlign: 'center',
    fontSize: 12,
    color: '#B0B0B0',
  },
});