
import { View, Text } from 'react-native'
import React from 'react'
import { Link } from 'expo-router'

const index = () => {
  return (
    <View>
        <Text>Hello</Text>
        <Link href="/(auth)/sign-in">
          <Text>Sign in</Text>
        </Link>
        
      
    </View>
  )
}

export default index