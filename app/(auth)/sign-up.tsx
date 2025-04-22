import * as React from 'react';
import { Text, TextInput, TouchableOpacity, View } from 'react-native';
import { useSignUp } from '@clerk/clerk-expo';
import { Link, useRouter } from 'expo-router';

export default function SignUpScreen() {
  const { isLoaded, signUp, setActive } = useSignUp();
  const router = useRouter();

  const [emailAddress, setEmailAddress] = React.useState('');
  const [password, setPassword] = React.useState('');
  const [pendingVerification, setPendingVerification] = React.useState(false);
  const [code, setCode] = React.useState('');
  const [alreadyVerifiedError, setAlreadyVerifiedError] = React.useState(false);
  const [verificationError, setVerificationError] = React.useState('');
  const [signUpErrorMessage, setSignUpErrorMessage] = React.useState('');

  const onSignUpPress = async () => {
    if (!isLoaded) return;

    try {
      await signUp.create({
        emailAddress,
        password,
      });

      await signUp.prepareEmailAddressVerification({ strategy: 'email_code' });
      setPendingVerification(true);
      setSignUpErrorMessage('');
    } catch (err) {
      console.error(JSON.stringify(err, null, 2));
      if (err?.status === 422 && err?.clerkError && Array.isArray(err?.errors)) {
        const errors = err.errors;
        let emailError = null;
        let passwordError = null;

        errors.forEach((error) => {
          if (error.code === 'form_param_nil' && error.meta?.paramName === 'email_address') {
            emailError = error.message;
          } else if (error.code === 'form_param_nil' && error.meta?.paramName === 'password') {
            passwordError = error.message;
          } else if (error.code === 'form_identifier_exists' && error.meta?.paramName === 'email_address') {
            emailError = error.message;
          }
        });

        if (emailError) {
          setSignUpErrorMessage(emailError);
        } else if (passwordError) {
          setSignUpErrorMessage(passwordError);
        } else {
          setSignUpErrorMessage('Sign up failed. Please try again.');
        }
      } else {
        setSignUpErrorMessage('An unexpected error occurred during sign up.');
      }
    }
  };

  const onVerifyPress = async () => {
    if (!isLoaded) return;

    try {
      const signUpAttempt = await signUp.attemptEmailAddressVerification({
        code,
      });

      if (signUpAttempt.status === 'complete') {
        await setActive({ session: signUpAttempt.createdSessionId });
        router.replace('/');
      } else {
        // Log the full signUpAttempt object to understand its structure
        console.log('signUpAttempt:', JSON.stringify(signUpAttempt, null, 2));
        setVerificationError('Verification failed. Please check the code and try again.');
      }
      setAlreadyVerifiedError(false); // Reset this error on a new attempt
    } catch (err) {
      console.error(JSON.stringify(err, null, 2));
      if (err.message?.includes('Email address is already verified')) {
        setAlreadyVerifiedError(true);
        setVerificationError('');
      } else if (err.message?.includes('Verification code is invalid')) {
        setVerificationError('Invalid verification code. Please try again.');
      }
       else {
        setVerificationError('Error during verification. Please try again.');
        setAlreadyVerifiedError(false);
      }
    }
  };

  if (pendingVerification) {
    return (
      <View className="bg-ash flex-1 justify-center items-center p-6">
        <View className="bg-back rounded-lg shadow-md p-8 w-full max-w-sm">
          <Text className="text-xl font-bold mb-4 text-center text-primary">Verify Your Email</Text>
          <Text className="text-sm text-second mb-2 text-center">
            We have sent a verification code to your email address. Please enter it below.
          </Text>
          <TextInput
            className="border border-second rounded-md px-4 py-3 mb-4 text-lg"
            value={code}
            placeholder="Verification Code"
            onChangeText={(text) => setCode(text)}
            keyboardType="numeric"
          />
          {verificationError ? (
            <Text className="text-red-500 text-sm mb-2">{verificationError}</Text>
          ) : null}
          {alreadyVerifiedError ? (
            <View className="mb-2">
              <Text className="text-info text-sm text-center">
                This email address is already verified. Please <Link href="/sign-in"><Text className="text-primary">sign in</Text></Link>.
              </Text>
            </View>
          ) : null}
          <TouchableOpacity
            onPress={onVerifyPress}
            className="bg-primary rounded-md py-3 items-center"
          >
            <Text className="text-back text-lg font-semibold">Verify</Text>
          </TouchableOpacity>
        </View>
      </View>
    );
  }

  return (
    <View className="bg-ash flex-1 flex-col ">
      <Text className="bg-back text-2xl py-5 mb-10 pl-5 ">Sign Up</Text>
      <View className="px-5">
        <View
          className="bg-back h-fit justify-center items-center px-6 py-10 rounded-lg shadow-md"
          style={{
            shadowColor: 'black',
            shadowOffset: { width: 1, height: 2 },
            shadowOpacity: 0.3,
            shadowRadius: 4,
            elevation: 5, // For Android
          }}
        >
          <Text className="text-sm justify-start w-full mb-2 mt-2 font-mono text-second">
            Email address
          </Text>
          <TextInput
            autoCapitalize="none"
            value={emailAddress}
            placeholder="Enter email"
            onChangeText={(text) => setEmailAddress(text)}
            className="border border-second rounded-md px-4 py-3 w-full mb-5 text-lg"
          />

          <Text className="text-sm justify-start w-full mb-2 mt-2 font-mono text-second">
            Password
          </Text>
          <TextInput
            value={password}
            placeholder="Enter password"
            secureTextEntry={true}
            onChangeText={(text) => setPassword(text)}
            className="border border-second rounded-md px-4 py-3 w-full mb-8 text-lg"
          />

          {signUpErrorMessage ? (
            <Text className="text-red-500 text-sm mb-2">{signUpErrorMessage}</Text>
          ) : null}

          <TouchableOpacity
            onPress={onSignUpPress}
            className="bg-primary rounded-md w-full py-3 mb-5 items-center"
          >
            <Text className="text-back text-lg font-semibold">Continue</Text>
          </TouchableOpacity>

          <View className="flex-row gap-3">
            <Text className="text-second font-mono">Already have an account?</Text>
            <Link href="/sign-in">
              <Text className="text-primary font-mono">Sign in</Text>
            </Link>
          </View>
        </View>
      </View>
    </View>
  );
}