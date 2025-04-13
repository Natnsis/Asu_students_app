import React, { useState } from 'react';
import { View, Text, StyleSheet, ScrollView, Alert, TouchableOpacity } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { Link } from 'expo-router';
import { useFocusEffect } from '@react-navigation/native'; // Import useFocusEffect

export default function TableClass() {
  const [classSchedule, setClassSchedule] = useState([]);

  // Fetch class schedule data from AsyncStorage
  const fetchClassSchedule = async () => {
    try {
      const storedClasses = await AsyncStorage.getItem('classSchedules');
      if (storedClasses) {
        setClassSchedule(JSON.parse(storedClasses));
      } else {
        setClassSchedule([]); // Set empty state if no data is found
      }
    } catch (error) {
      console.error('Error fetching class schedule:', error);
      Alert.alert('Error', 'Failed to fetch class schedule.');
    }
  };

  // Refresh data when the screen is focused
  useFocusEffect(
    React.useCallback(() => {
      fetchClassSchedule();
    }, [])
  );

  // Check if the table is empty or contains only unavailable spots
  const isTableEmpty = classSchedule.length === 0 || classSchedule.every((item) =>
    (!item.subject || item.subject === '-') &&
    (!item.time || item.time === '-') &&
    (!item.room || item.room === '-')
  );

  return (
    <View style={styles.container}>
      <ScrollView contentContainerStyle={styles.scrollContent}>
        <Text style={styles.title}>Class Schedule</Text>

        {/* Description below the header */}
        <Text style={styles.description}>
          You can edit the class schedule by pressing the button below and saving changes after applying updates.
        </Text>

        <View style={styles.table}>
          {/* Table Header */}
          <View style={[styles.row, styles.headerRow]}>
            <Text style={[styles.cell, styles.headerCell]}>Day</Text>
            <Text style={[styles.cell, styles.headerCell]}>Subject</Text>
            <Text style={[styles.cell, styles.headerCell]}>Time</Text>
            <Text style={[styles.cell, styles.headerCell]}>Room</Text>
          </View>

          {/* Table Rows */}
          {classSchedule.map((item) => (
            <View key={item.id} style={styles.row}>
              <Text style={styles.cell}>{item.day}</Text>
              <Text style={styles.cell}>{item.subject || '-'}</Text>
              <Text style={styles.cell}>{item.time || '-'}</Text>
              <Text style={styles.cell}>{item.room || '-'}</Text>
            </View>
          ))}
        </View>

        {/* Exception Handling: Display message if table is empty */}
        {isTableEmpty && (
          <Text style={styles.emptyMessage}>
            The class schedule is currently empty or contains unavailable spots. Please edit the schedule to add details.
          </Text>
        )}
      </ScrollView>

      {/* Edit Button */}
      <TouchableOpacity style={styles.editButton}>
        <Link href="../addClass" style={styles.editButtonText}>
          Edit Class Schedule
        </Link>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'white',
  },
  scrollContent: {
    padding: 16,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    textAlign: 'center',
    marginBottom: 8,
  },
  description: {
    fontSize: 14,
    textAlign: 'center',
    color: '#555',
    marginBottom: 16,
  },
  table: {
    borderWidth: 1,
    borderColor: '#ccc',
    borderRadius: 8,
    overflow: 'hidden',
  },
  row: {
    flexDirection: 'row',
    borderBottomWidth: 1,
    borderBottomColor: '#ccc',
    paddingVertical: 12,
  },
  headerRow: {
    backgroundColor: '#f0f0f0',
  },
  cell: {
    flex: 1,
    paddingVertical: 12,
    paddingHorizontal: 8,
    textAlign: 'center',
    fontSize: 16,
  },
  headerCell: {
    fontWeight: 'bold',
    fontSize: 18,
  },
  emptyMessage: {
    marginTop: 16,
    fontSize: 14,
    textAlign: 'center',
    color: 'red',
  },
  editButton: {
    backgroundColor: 'green',
    padding: 12,
    borderRadius: 8,
    alignItems: 'center',
    margin: 16,
  },
  editButtonText: {
    color: 'white',
    fontSize: 16,
    fontWeight: 'bold',
  },
});