import React from 'react';
import { View, Text, StyleSheet, TouchableOpacity } from 'react-native';

export default function QuantumScreen({ navigation }) {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>⚛️ Quantum Processing</Text>
      <Text style={styles.description}>
        Experience the power of quantum computing with our advanced processing capabilities.
      </Text>

      <View style={styles.card}>
        <Text style={styles.cardTitle}>Quantum Features</Text>
        <Text style={styles.cardText}>• Superposition</Text>
        <Text style={styles.cardText}>• Entanglement</Text>
        <Text style={styles.cardText}>• Quantum Tunneling</Text>
      </View>

      <TouchableOpacity style={styles.backButton} onPress={() => navigation.goBack()}>
        <Text style={styles.buttonText}>Back to Home</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#0A0E27',
    padding: 20,
    paddingTop: 60,
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#00D9FF',
    marginBottom: 20,
    textAlign: 'center',
  },
  description: {
    fontSize: 16,
    color: '#FFFFFF',
    marginBottom: 30,
    textAlign: 'center',
    lineHeight: 24,
  },
  card: {
    backgroundColor: '#1A1F4B',
    padding: 20,
    borderRadius: 10,
    marginBottom: 20,
  },
  cardTitle: {
    color: '#00D9FF',
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 15,
  },
  cardText: {
    color: '#FFFFFF',
    fontSize: 16,
    marginBottom: 10,
    marginLeft: 10,
  },
  backButton: {
    backgroundColor: '#1A1F4B',
    padding: 15,
    borderRadius: 10,
    width: '100%',
    alignItems: 'center',
    position: 'absolute',
    bottom: 30,
    left: 20,
    right: 20,
  },
  buttonText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: '600',
  },
});
