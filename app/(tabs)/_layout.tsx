import { Tabs } from 'expo-router';
import { MaterialIcons } from '@expo/vector-icons';
import React from 'react';

export default function TabLayout() {
  return (
    <Tabs
      screenOptions={{
        tabBarActiveTintColor: 'blue',
        tabBarInactiveTintColor: 'lightblue',
        headerShown: false,
      }}
    >
      <Tabs.Screen
        name="home/index"
        options={{
          title: 'Home',
          tabBarIcon: ({ color }) => (
            <MaterialIcons name="home" size={24} color={color} />
          ),
        }}
      />
      <Tabs.Screen
        name="explore/index"
        options={{
          title: 'Explore',
          tabBarIcon: ({ color }) => (
            <MaterialIcons name="explore" size={24} color={color} />
          ),
        }}
      />
      <Tabs.Screen
        name="notes/index"
        options={{
          title: 'Notes',
          tabBarIcon: ({ color }) => (
            <MaterialIcons name="note" size={24} color={color} />
          ),
        }}
      />
      <Tabs.Screen
        name="community/index"
        options={{
          title: 'Community',
          tabBarIcon: ({ color }) => (
            <MaterialIcons name="people" size={24} color={color} />
          ),
        }}
      />
      
    </Tabs>
  );
}