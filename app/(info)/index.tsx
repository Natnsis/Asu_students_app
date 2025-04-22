import { View, Text, TextInput, TouchableOpacity } from 'react-native';
import RNPickerSelect from 'react-native-picker-select';
import AsyncStorage from '@react-native-async-storage/async-storage';
import React, { useState } from 'react';
import { navigate } from 'expo-router/build/global-state/routing';
import { router } from 'expo-router';

const index = () => {
  const [selectedDepartment, setSelectedDepartment] = useState(null);
  const [selectedGender, setSelectedGender] = useState(null);
  const [selectedYear, setSelectedYear] = useState(null);
  const [fullName, setFullName] = useState('');
  const [studentId, setStudentId] = useState('');

  const items = [
    { label: 'Haven\'t chosen yet', value: '-' },
    { label: 'Accounting & Finance', value: 'Acc' },
    { label: 'Agricultural', value: 'Agri' },
    { label: 'Business Administration', value: 'Bus' },
    { label: 'Civics ', value: 'Civ' },
    { label: 'Civil Engineering', value: 'Civil' },
    { label: 'Computer Science', value: 'CS' },
    { label: 'Economics', value: 'Eco' },
    { label: 'Electrical Engineering', value: 'Elel' },
    { label: 'English Language and Literature', value: 'Eng' },
    { label: 'Health Officer', value: 'HO' },
    { label: 'Hydraulic Engineering ', value: 'Hyd' },
    { label: 'Information Technology', value: 'It' },
    { label: 'Journalism', value: 'Jour' },
    { label: 'Management', value: 'Mana' },
    { label: 'Mathematics', value: 'Math' },
    { label: 'Mechanical Engineering ', value: 'Mech' },
    { label: 'Nursing', value: 'Nurs' },
    { label: 'Pharmacy', value: 'Phar' },
    { label: 'Physics', value: 'Phys' },
    { label: 'Plant', value: 'Pla' },
    { label: 'Psychology', value: 'Psyc' },
    { label: 'Surveying Engineering', value: 'Surv' },
    { label: 'Other', value: '-' },
  ];

  const Gender = [
    { label: 'Male', value: 'male' },
    { label: 'Female', value: 'female' },
  ];

  const Year = [
    { label: 'Remedial', value: '0' },
    { label: 'Freshmen (1st year)', value: '1' },
    { label: '2nd Year', value: '2' },
    { label: '3rd Year', value: '3' },
    { label: '4th Year', value: '4' },
    { label: 'Sth Year', value: '5' },
  ];

  const saveData = async () => {
    try {
      const userData = {
        fullName: fullName,
        studentId: studentId,
        department: selectedDepartment,
        gender: selectedGender,
        year: selectedYear,
      };
      const jsonValue = JSON.stringify(userData);
      await AsyncStorage.setItem('asuCredentials', jsonValue);
      alert('ASU credentials saved successfully!');
      router.replace('/(home)');
    } catch (error) {
      console.error('Error saving data:', error);
      alert('Failed to save credentials.');
    }
  };

  return (
    <View className='bg-ash flex-1 justify-center items-center'>
      <View className='bg-back p-5 rounded-lg w-[90vw]'>
        <Text className='text-3xl font-extrabold px-3 mb-3 text-center'>
          Enter your ASU credentials
        </Text>
        <Text className='text-sm text-second px-3 mb-1'>
          Full Name
        </Text>
        <TextInput
          autoCapitalize="none"
          placeholder="john doe"
          className='border border-second rounded-md px-2 py-3 w-full mb-5'
          value={fullName}
          onChangeText={setFullName}
        />
        <Text className='text-sm text-second  px-3 mb-1'>
          ID
        </Text>
        <TextInput
          autoCapitalize="none"
          placeholder="RU/1234/56"
          className='border border-second rounded-md px-2 py-3 w-full mb-5'
          value={studentId}
          onChangeText={setStudentId}
        />

        <Text className='text-sm text-second px-3 mb-1 mt-5'>
          Department
        </Text>
        <RNPickerSelect
          onValueChange={(value) => setSelectedDepartment(value)}
          items={items}
          placeholder={{ label: 'Select an item...', value: null }}
          value={selectedDepartment}
        />
        <Text className='text-sm text-second px-3 mb-1 mt-5'>
          Gender
        </Text>
        <RNPickerSelect
          onValueChange={(value) => setSelectedGender(value)}
          items={Gender}
          placeholder={{ label: 'Select an item...', value: null }}
          value={selectedGender}
        />
        <Text className='text-sm text-second px-3 mb-1 mt-5'>
          Year
        </Text>
        <RNPickerSelect
          onValueChange={(value) => setSelectedYear(value)}
          items={Year}
          placeholder={{ label: 'Select an item...', value: null }}
          value={selectedYear}
        />

        <TouchableOpacity onPress={saveData} className='bg-primary rounded-md w-full py-3 mb-5 mt-5 '>
          <Text className='text-back text-bold text-xl w-full text-center'>
            Finished Setting up🎉
          </Text>
        </TouchableOpacity>
      </View>
    </View>
  );
};

export default index;