import React from 'react';
import Container from '@cloudscape-design/components/container';
import Box from '@cloudscape-design/components/box';
import TextContent from '@cloudscape-design/components/text-content';

export default function RemoteDashboard() {
  return (
    <Container header="Dashboard Overview">
      <Box>
        <TextContent>
          <h3>Welcome to the Dashboard</h3>
          <p>This is the dashboard micro frontend loaded dynamically.</p>
        </TextContent>
      </Box>
    </Container>
  );
}