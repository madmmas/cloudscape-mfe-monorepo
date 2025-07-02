import React from 'react';
import { TopNavigation } from '@cloudscape-design/components';

export default function Header() {
  return (
    <TopNavigation
      identity={{
        href: '/',
        title: 'Micro Frontend App',
      }}
      utilities={[
        {
          type: 'button',
          text: 'Settings',
          iconName: 'settings',
        },
        {
          type: 'menu-dropdown',
          text: 'User',
          iconName: 'user-profile',
          items: [
            { id: 'profile', text: 'Profile' },
            { id: 'preferences', text: 'Preferences' },
            { id: 'signout', text: 'Sign out' },
          ],
        },
      ]}
    />
  );
} 