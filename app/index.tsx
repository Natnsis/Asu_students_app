
import { View, Text, Image, TouchableOpacity } from 'react-native'
import React from 'react'
import { Link } from 'expo-router'

const index = () => {
  return (
    <View className='bg-back flex-1 px-5 '>
        <Text className='text-5xl text-center mt-10 '>Welcome to ASU Students App</Text>
        <Text className='text-second font-mono mt-5 text-center'>
          Access your academic resources, campus events and student services all in one
        </Text>          
        <Image
            source={require('../assets/images/logo.jpg')}
            className='w-full h-[20vh] mx-auto mt-10'
            resizeMode='contain'
          />
        
        <TouchableOpacity className='bg-primary flex-row justify-center items-center py-4 mt-5 rounded-lg'>
          <Link href="/(auth)/sign-in" className='text-center w-full text-xl'>
            <Text className='text-back'>Sign in</Text>
          </Link>
        </TouchableOpacity>

        <Text className='text-center text-second font-mono mt-5 mb-3'>New to the platform?</Text>
        <Text className='text-second font-mono text-center'>Create an Account to get started <Link href="/(auth)/sign-up" className='text-primary font-bold'>Register Here!</Link></Text>

        <View className='absolute bottom-0 flex-row justify-between items-center px-10 gap-2'>
          <Text className='text-sm text-second font-mono'>
            🔒 secure login
          </Text>
          <Text className='text-sm text-second font-mono'>
           🤳 user friendly
          </Text>
          <Text className='text-sm text-second font-mono'>
            💭 24/7 support
          </Text>

        </View>
   
        
        
        
      
    </View>
  )
}

export default index