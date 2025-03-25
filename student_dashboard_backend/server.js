const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv");
const connectDB = require("./config/db");

dotenv.config();
connectDB();

const app = express();
app.use(cors());
app.use(express.json()); // ✅ Ensure JSON body is parsed

app.get("/", (req, res) => res.send("API is running..."));

// ✅ Import Routes
const studentRoutes = require("./routes/student");
app.use("/api/student", studentRoutes); // ✅ Use Routes

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
