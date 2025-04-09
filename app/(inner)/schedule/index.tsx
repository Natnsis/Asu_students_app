import { ScrollView, StyleSheet, Text, TextInput, TouchableOpacity, View } from 'react-native';
import React, { useState } from 'react';
import { MaterialIcons } from '@expo/vector-icons';

export default function index() {
  const [editingId, setEditingId] = useState(null);
  const [days, setDays] = useState([
    { id: 1, name: 'Monday', breakfast: 'shiro', lunch: 'misir', dinner: 'rise' },
    { id: 2, name: 'Tuesday', breakfast: 'shiro', lunch: 'misir', dinner: 'rise' },
    { id: 3, name: 'Wednesday', breakfast: 'shiro', lunch: 'misir', dinner: 'rise' },
    { id: 4, name: 'Thursday', breakfast: 'shiro', lunch: 'misir', dinner: 'rise' },
    { id: 5, name: 'Friday', breakfast: 'shiro', lunch: 'misir', dinner: 'rise' },
    { id: 6, name: 'Saturday', breakfast: 'shiro', lunch: 'misir', dinner: 'rise' },
    { id: 7, name: 'Sunday', breakfast: 'shiro', lunch: 'misir', dinner: 'rise' },
  ]);

  return (
    <ScrollView style={styles.main}>
      <View style={styles.head}>
        <Text style={styles.title}>Cafeteria Schedule</Text>
        <Text style={styles.description}>
          Add up the schedule provided by the university and access it any time, it's simple! Just press the inputs and fill up, then save 😊
        </Text>
      </View>
      <View style={styles.container}>
        {/* Table Header */}
        <View style={styles.headerRow}>
          <Text style={styles.headerCell}>Day</Text>
          <Text style={styles.headerCell}>Food</Text>
          <Text style={styles.headerCell}>Action</Text>
        </View>

        {/* Table Rows */}
        {days.map((day) => (
          <View key={day.id} style={styles.row}>
            <Text style={styles.cell}>{day.name}</Text>
            <View style={styles.foodColumn}>
              <TextInput
                style={styles.input}
                value={day.breakfast}
                placeholder="Breakfast"
                onChangeText={(text) => {}}
              />
              <TextInput
                style={styles.input}
                value={day.lunch}
                placeholder="Lunch"
                onChangeText={(text) => {}}
              />
              <TextInput
                style={styles.input}
                value={day.dinner}
                placeholder="Dinner"
                onChangeText={(text) => {}}
              />
            </View>
            <TouchableOpacity style={styles.button} onPress={() => {}}>
              <MaterialIcons name="save" size={20} color="green" />
            </TouchableOpacity>
          </View>
        ))}
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  main: { backgroundColor: 'white', flex: 1 },
  container: { padding: 16 },
  headerRow: {
    flexDirection: 'row',
    borderBottomWidth: 1,
    paddingVertical: 8,
  },
  headerCell: {
    flex: 1,
    fontWeight: 'bold',
    textAlign: 'center',
  },
  cell: {
    flex: 1,
    textAlign: 'center',
  },
  foodColumn: {
    flex: 2, // Adjusted to take more space for the food inputs
    flexDirection: 'column',
  },
  input: {
    borderRadius: 4,
    borderWidth: 1,
    marginVertical: 4,
    padding: 4,
  },
  button: {
    padding: 8,
    borderRadius: 4,
  },
  row: {
    flexDirection: 'row',
    borderBottomWidth: 1,
    paddingVertical: 12,
    alignItems: 'center',
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