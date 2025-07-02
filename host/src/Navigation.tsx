import React from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { SideNavigation } from '@cloudscape-design/components';

export default function Navigation() {
  const navigate = useNavigate();
  const location = useLocation();

  const navigationItems = [
    {
      type: 'link' as const,
      text: 'Dashboard',
      href: '/dashboard',
    },
    {
      type: 'link' as const,
      text: 'Orders',
      href: '/orders',
    },
  ];

  return (
    <SideNavigation
      items={navigationItems}
      onFollow={(event) => {
        if (!event.detail.external) {
          event.preventDefault();
          navigate(event.detail.href);
        }
      }}
    />
  );
} 