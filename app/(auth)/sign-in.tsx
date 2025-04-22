import { useSignIn } from '@clerk/clerk-expo'
import { Link, useRouter } from 'expo-router'
import { Text, TextInput, TouchableOpacity, View, Image } from 'react-native'
import Icon from 'react-native-vector-icons/MaterialIcons'; 
import React from 'react'

export default function Page() {
  const { signIn, setActive, isLoaded } = useSignIn()
  const router = useRouter()

  const [emailAddress, setEmailAddress] = React.useState('')
  const [password, setPassword] = React.useState('')

  // Handle the submission of the sign-in form
  const onSignInPress = async () => {
    if (!isLoaded) return

    // Start the sign-in process using the email and password provided
    try {
      const signInAttempt = await signIn.create({
        identifier: emailAddress,
        password,
      })

      // If sign-in process is complete, set the created session as active
      // and redirect the user
      if (signInAttempt.status === 'complete') {
        await setActive({ session: signInAttempt.createdSessionId })
        router.replace('../(home)')
      } else {
        // If the status isn't complete, check why. User might need to
        // complete further steps.
        console.error(JSON.stringify(signInAttempt, null, 2))
      }
    } catch (err) {
      // See https://clerk.com/docs/custom-flows/error-handling
      // for more info on error handling
      console.error(JSON.stringify(err, null, 2))
    }
  }

  return (
    <View className='bg-ash flex-1 flex-col '>
      <Text className='bg-back text-2xl py-5 mb-10 pl-5 '>Sign in</Text>

      <View className='px-5'  >
        <View className='bg-back h-fit justify-center items-center px-2 py-10 rounded-lg'
        style={{
          shadowColor: 'black',
          shadowOffset: { width: 1, height: 2 },
          shadowOpacity: 0.5,
          shadowRadius: 5,
          elevation: 5, // For Android
        }}
        >
          <Text className='text-3xl font-extrabold w-full px-3 mb-2'>Welcome back</Text>
          <Text className='text-sm text-second w-full px-3'>Sign in to access your account!</Text>

          <Text className='text-sm justify-start w-[80vw] mb-1 mt-5 font-mono '>Email address</Text>
          <TextInput
            autoCapitalize="none"
            value={emailAddress}
            placeholder="example@gmail.com"
            className='border border-second rounded-md px-2 py-3 w-[80vw] mb-5'
            onChangeText={(emailAddress) => setEmailAddress(emailAddress)}
          />

        <Text className='text-sm justify-start w-[80vw] mb-1 mt-5 font-mono '>Password</Text>
        <TextInput
          value={password}
          placeholder="********"
          secureTextEntry={true}
          className='border border-second rounded-md px-2 py-3 w-[80vw] mb-8'
          onChangeText={(password) => setPassword(password)}
        />

        <TouchableOpacity onPress={onSignInPress} className='bg-primary rounded-md w-full py-3 mb-5 '>
          <Text className='text-back text-bold text-xl w-full text-center'>Continue</Text>
        </TouchableOpacity>

          <View className='flex flex-row items-center'>
            <View className='border-t border-gray-300 flex-1' />
              <Text className='mx-4 text-gray-500 font-mono w-[5vw]'>or</Text>
            <View className='border-t border-gray-300 flex-1' />
          </View>

          <View className='border-second px-3 pt-5 border h-fit w-full flex-row justify-center rounded-lg mb-5 pb-5'>
            <Link href="/" className='flex-row items-center justify-center h-10 w-full'>
              <Image
                source={require('../../assets/images/google.png')}
                className='w-10 h-8 bg-primary '
              />
              <View className='flex-1 flex-col justify-center px-2 h-full'> {/* Wrapper View */}
                <Text className='font-bold text-lg' style={{ lineHeight: 20 }}>
                  Continue with Google
                </Text>
              </View>
            </Link>
          </View>

          <View className='flex mb-5'>
            <Text className='text-center text-primary font-mono '>Forgot your password?</Text>
          </View>

        <View style={{ display: 'flex', flexDirection: 'row', gap: 3 }}>
          <Text className='text-second font-mono'>Don't have an account?</Text>
          <Link href="/sign-up">
            <Text className='text-primary font-mono'>Sign up</Text>
          </Link>
        </View>
        </View>
      </View>

      
    </View>
  )
}