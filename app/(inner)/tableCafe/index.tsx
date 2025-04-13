import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet, ScrollView, Alert, TouchableOpacity } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { Link } from 'expo-router';

export default function TableCafe() {
  const [schedule, setSchedule] = useState([]);

  // Fetch schedule data from AsyncStorage
  useEffect(() => {
    const fetchSchedule = async () => {
      try {
        const storedDays = await AsyncStorage.getItem('schedules');
        if (storedDays) {
          setSchedule(JSON.parse(storedDays));
        } else {
          Alert.alert('No Data', 'No schedule data found.');
        }
      } catch (error) {
        console.error('Error fetching schedule:', error);
      }
    };

    fetchSchedule();
  }, []);

  // Check if the table is empty or contains only unavailable spots
  const isTableEmpty = schedule.length === 0 || schedule.every((item) =>
    (!item.breakfast || item.breakfast === '-') &&
    (!item.lunch || item.lunch === '-') &&
    (!item.dinner || item.dinner === '-')
  );

  return (
    <View style={styles.container}>
      <ScrollView contentContainerStyle={styles.scrollContent}>
        <Text style={styles.title}>Cafeteria Schedule</Text>

        {/* Description below the header */}
        <Text style={styles.description}>
          You can edit the schedule by pressing the button below and saving changes after applying updates.
        </Text>

        <View style={styles.table}>
          {/* Table Header */}
          <View style={[styles.row, styles.headerRow]}>
            <Text style={[styles.cell, styles.headerCell]}>Day</Text>
            <Text style={[styles.cell, styles.headerCell]}>Breakfast</Text>
            <Text style={[styles.cell, styles.headerCell]}>Lunch</Text>
            <Text style={[styles.cell, styles.headerCell]}>Dinner</Text>
          </View>

          {/* Table Rows */}
          {schedule.map((item) => (
            <View key={item.id} style={styles.row}>
              <Text style={styles.cell}>{item.day}</Text>
              <Text style={styles.cell}>{item.breakfast || '-'}</Text>
              <Text style={styles.cell}>{item.lunch || '-'}</Text>
              <Text style={styles.cell}>{item.dinner || '-'}</Text>
            </View>
          ))}
        </View>

        {/* Exception Handling: Display message if table is empty */}
        {isTableEmpty && (
          <Text style={styles.emptyMessage}>
            The schedule is currently empty or contains unavailable spots. Please edit the schedule to add details.
          </Text>
        )}
      </ScrollView>

      {/* Edit Button */}
      <TouchableOpacity style={styles.editButton}>
        <Link href="../schedule" style={styles.editButtonText}>
          Edit Schedule
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