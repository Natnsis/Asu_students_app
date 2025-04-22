import { SignedIn, SignedOut, useUser } from '@clerk/clerk-expo';
import { Link, useRouter } from 'expo-router';
import { Text, View } from 'react-native';
import { SignOutButton } from '../components/SignOutButton';
import Ionicons from '@expo/vector-icons/Ionicons';
import React ,{  useEffect, useState }from 'react';
import AsyncStorage from '@react-native-async-storage/async-storage';


///TODO: USE AYNC STORAGE TO FETCH CREDENTIALS
export default function Page() {
  const { user } = useUser();
  const router = useRouter();
  const [hasCredentials, setHasCredentials] = useState(null);
  const [localFirstName, setLocalFirstName] = useState(''); // State for first name from AsyncStorage

  useEffect(() => {
    const checkCredentials = async () => {
      try {
        const credentials = await AsyncStorage.getItem('asuCredentials');
        setHasCredentials(credentials !== null);
        if (credentials) {
          const parsedCredentials = JSON.parse(credentials);
          setLocalFirstName(parsedCredentials?.fullName?.split(' ')[0] || ''); // Extract first name
        }
      } catch (error) {
        console.error('Error checking credentials:', error);
        setHasCredentials(false);
      }
    };

    checkCredentials();
  }, []);

  useEffect(() => {
    if (user && hasCredentials === false) {
      router.replace('/setup');
    } else if (user && hasCredentials === true) {
      router.replace('/home');
    }
  }, [user, hasCredentials, router]);

  if (hasCredentials === null) {
    return (
      <View className="bg-backlight flex-1 justify-center items-center">
        <Text>Checking setup...</Text>
      </View>
    );
  }

  return (
    <View className="bg-backlight flex-1 p-6">
      <View className="flex-row justify-between items-center mb-4">
        <Ionicons name="menu" size={36} color="black" />
        <SignedIn>
          <Text>
            Hello {localFirstName || user?.firstName || user?.emailAddresses[0]?.emailAddress}
          </Text>
          <SignOutButton />
        </SignedIn>
        <SignedOut>
          <Link href="/(auth)/sign-in">
            <Text>Sign in</Text>
          </Link>
          <Link href="/(auth)/sign-up">
            <Text>Sign up</Text>
          </Link>
        </SignedOut>
      </View>
    </View>
  );
}