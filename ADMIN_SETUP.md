# Admin Panel Setup Guide

## ✅ What's Been Created

### Frontend (Flutter)
1. **Admin Login Screen** - `/admin` route
2. **Admin Panel Dashboard** - Main admin interface
3. **Content Management** - Full CRUD for website content
4. **Content Form** - Add/Edit content with validation
5. **Models & Services** - API integration ready

### Backend (Node.js + MongoDB)
1. **Content Model** - MongoDB schema
2. **Content Routes** - Full REST API (GET, POST, PUT, DELETE)
3. **Server Integration** - Routes connected to Express

---

## 🚀 How to Run

### 1. Start Backend Server
```bash
cd lib/backend
node server.js
```
Server will run on `http://localhost:3000`

### 2. Start Flutter App
```bash
flutter run -d chrome  # For web
# or
flutter run  # For mobile
```

### 3. Access Admin Panel
Navigate to: `http://localhost:PORT/admin`

---

## 🔑 How Clients Use It

### Login Flow:
1. Client goes to `/admin`
2. Enters email & password (currently accepts any for demo)
3. Redirects to Admin Dashboard

### Managing Content:
1. Click **"Manage Content"** card
2. See list of all content (services, blogs, events, news)
3. **Filter** by category using chips at top
4. **Add New**: Click floating "+" button
5. **Edit**: Click edit icon on any item
6. **Delete**: Click delete icon (with confirmation)

### Creating/Editing Content:
1. Fill in:
   - Title (required)
   - Description (required)
   - Category (dropdown: service/blog/event/news)
   - Image URL (optional)
   - Publish toggle (draft or live)
2. Click **"Create"** or **"Update"**
3. Success message appears
4. Returns to content list

---

## 📝 What Clients Can Do

✅ Add new services, blogs, events, news
✅ Edit existing content
✅ Delete content (with confirmation)
✅ Save as draft or publish immediately
✅ Filter content by category
✅ See publish status at a glance

---

## 🔧 Configuration

### Update Backend URL
In `lib/services/content_service.dart`, line 6:
```dart
static const String baseUrl = 'http://YOUR_SERVER:3000/api/content';
```

### MongoDB Connection
In `lib/backend/.env`:
```
MONGO_URI=your_mongodb_connection_string
PORT=3000
```

---

## 🔐 Next Steps (TODO)

1. **Add Real Authentication**
   - Integrate Firebase Auth in `admin_login_screen.dart`
   - Add JWT tokens for backend API
   - Protect routes with auth middleware

2. **Add Image Upload**
   - Integrate Firebase Storage or Cloudinary
   - Replace image URL field with file picker

3. **Add More Content Types**
   - Testimonials
   - Team members
   - FAQs
   - etc.

4. **Add Analytics Dashboard**
   - View counts
   - User engagement
   - Popular content

---

## 📱 Testing

### Test Backend API:
```bash
# Get all content
curl http://localhost:3000/api/content

# Create content
curl -X POST http://localhost:3000/api/content \
  -H "Content-Type: application/json" \
  -d '{"title":"Test","description":"Test desc","category":"blog"}'
```

### Test Frontend:
1. Run app
2. Navigate to `/admin`
3. Login with any credentials
4. Try creating, editing, deleting content

---

## 🎯 Client Credentials

**For Demo (accepts anything):**
- Email: admin@example.com
- Password: password123

**After implementing Firebase Auth:**
Create admin users in Firebase Console and share credentials with client.

---

## 💡 Tips

- Backend must be running before testing CRUD operations
- Check browser console for API errors
- MongoDB must be connected (check server logs)
- Use Chrome DevTools Network tab to debug API calls
