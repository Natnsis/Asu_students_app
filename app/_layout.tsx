import { ClerkProvider } from '@clerk/clerk-expo';
import { tokenCache } from '@clerk/clerk-expo/token-cache';
import { Stack } from 'expo-router';
import './global.css';
import React from 'react';

export default function RootLayoutNav() {
  return (
    <ClerkProvider tokenCache={tokenCache}>
      <Stack
        screenOptions={{
          headerShown: false,
        }}
      />
    </ClerkProvider>
  );
}