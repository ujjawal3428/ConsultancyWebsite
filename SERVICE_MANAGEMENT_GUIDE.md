# Service Management System Guide

## Overview

The Service Management System allows you to fully control your website's service page through the admin panel. You can manage:
- **Categories** (Medical, Engineering, Commerce, etc.)
- **Degrees** (MBBS, B.Tech, MBA, etc.)
- **Colleges** (Individual institutions with all details)

## Features

### 1. Categories Management
- Create, edit, and delete service categories
- Customize category icons and colors
- Set display order
- Toggle active/inactive status

### 2. Degrees Management
- Add degrees under specific categories
- Edit degree names and descriptions
- Organize degrees by display order
- Enable/disable degrees

### 3. Colleges Management
- Add colleges with complete details:
  - Name, city, state
  - Description
  - Type (Government/Private)
  - Admission deadline
  - Duration (in months)
  - Custom icon
- Link colleges to specific degrees and categories
- Set display order
- Toggle active/inactive status

## Getting Started

### Step 1: Migrate Existing Data

1. Log in to the admin panel
2. Navigate to **Manage Services**
3. Go to the **Categories** tab
4. Click the **"Migrate Static Data to Firestore"** button
5. Wait for the migration to complete

This will transfer all your existing static data (from `college.dart`) to Firestore.

### Step 2: Managing Content

#### Adding a New Category

1. Go to **Manage Services** → **Categories** tab
2. Click **"Add Category"**
3. Fill in:
   - Key (e.g., "medical", "engineering")
   - Title (e.g., "Medical", "Engineering")
   - Select an icon
   - Choose a color
   - Set display order
   - Toggle active status
4. Click **"Create Category"**

#### Adding a New Degree

1. Go to **Manage Services** → **Degrees** tab
2. Click **"Add Degree"**
3. Fill in:
   - Select category
   - Degree name (e.g., "MBBS", "B.Tech")
   - Description (optional)
   - Display order
   - Active status
4. Click **"Create Degree"**

#### Adding a New College

1. Go to **Manage Services** → **Colleges** tab
2. Click **"Add College"**
3. Fill in all required fields:
   - Category and Degree
   - College name
   - City and State
   - Description
   - Type (Government/Private)
   - Admission deadline
   - Duration in months
   - Select an icon
   - Display order
   - Active status
4. Click **"Create College"**

### Step 3: Editing and Deleting

- Click the **Edit** (blue) icon to modify any item
- Click the **Delete** (red) icon to remove any item
- Confirm deletion when prompted

## Data Structure

### Firestore Collections

The system uses three Firestore collections:

1. **service_categories**
   - Stores all service categories
   - Fields: key, title, iconName, colorHex, order, isActive

2. **service_degrees**
   - Stores all degrees/courses
   - Fields: categoryId, name, description, order, isActive

3. **service_colleges**
   - Stores all colleges
   - Fields: categoryId, degreeId, name, state, city, iconName, description, type, admissionDeadline, duration, order, isActive

### Relationships

```
Category (1) → (Many) Degrees
Degree (1) → (Many) Colleges
Category (1) → (Many) Colleges
```

## Available Icons

The system supports the following icons:
- `business_center` - Business/General
- `local_hospital` - Medical
- `engineering` - Engineering
- `computer` - Computer/IT
- `school` - Education/General
- `science` - Science
- `gavel` - Law
- `medical_services` - Medical Services
- `attach_money` - Commerce/Finance

## Available Colors

- Red (#EF4444)
- Blue (#3B82F6)
- Green (#10B981)
- Purple (#8B5CF6)
- Amber (#F59E0B)
- Cyan (#06B6D4)
- Indigo (#6366F1)
- Pink (#EC4899)

## Best Practices

1. **Display Order**: Use incremental numbers (0, 1, 2, 3...) for consistent ordering
2. **Keys**: Use lowercase, no spaces (e.g., "medical", "engineering")
3. **Active Status**: Disable items instead of deleting to preserve data
4. **Migration**: Only run the migration once to avoid duplicates
5. **Backup**: Always backup your Firestore data before bulk operations

## Troubleshooting

### Migration Issues
- Ensure you have proper Firestore permissions
- Check your internet connection
- Verify Firebase configuration

### Data Not Showing
- Check if items are marked as "Active"
- Verify the display order is set correctly
- Ensure proper category-degree-college relationships

### Permission Errors
- Verify your admin account has `editContent` permission
- Check Firestore security rules

## Future Enhancements

Potential features to add:
- Bulk import/export via CSV
- Image uploads for college logos
- Advanced filtering and search
- College ratings and reviews
- Application tracking
- Email notifications for deadline reminders

## Support

For issues or questions, contact your system administrator.
