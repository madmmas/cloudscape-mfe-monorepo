import React from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import AppLayout from '@cloudscape-design/components/app-layout';
import '@cloudscape-design/global-styles/index.css';

const Dashboard = React.lazy(() => import('dashboard/RemoteDashboard'));
const Orders = React.lazy(() => import('orders/RemoteOrders'));

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.Suspense fallback={<div>Loading...</div>}>
    <BrowserRouter>
      <AppLayout
        navigation={<div>Micro FE Nav</div>}
        content={
          <Routes>
            <Route path="/dashboard" element={<Dashboard />} />
            <Route path="/orders" element={<Orders />} />
            <Route path="*" element={<Navigate to="/dashboard" />} />
          </Routes>
        }
      />
    </BrowserRouter>
  </React.Suspense>
);