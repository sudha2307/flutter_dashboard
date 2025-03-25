const express = require("express");
const Student = require("../models/student");

const router = express.Router(); // ✅ Initialize Router

// ✅ Student Login Route
router.post("/login", async (req, res) => {
    try {
        console.log("Received Login Request:", req.body); // ✅ Debugging

        const { rollNumber, password } = req.body;
        if (!rollNumber || !password) {
            return res.status(400).json({ error: "Missing rollNumber or password" });
        }

        const student = await Student.findOne({ rollNumber });

        if (!student) {
            console.log("User not found");
            return res.status(400).json({ error: "User not found" });
        }

        if (student.password !== password) {
            console.log("Invalid password");
            return res.status(400).json({ error: "Invalid password" });
        }

        console.log("Login successful");
        res.json({ message: "Login successful", student });
    } catch (error) {
        console.error("Login error:", error);
        res.status(500).json({ error: "Server error" });
    }
});

// ✅ Register Student
router.post("/register", async (req, res) => {
    try {
        const { rollNumber, password, name, department, age, year, attendance } = req.body;

        const newStudent = new Student({
            rollNumber,
            password, // Saved in plain text (not recommended)
            name,
            department,
            age,
            year,
            attendance
        });

        await newStudent.save();
        res.status(201).json({ message: "Student registered successfully", student: newStudent });
    } catch (error) {
        console.error("Registration error:", error);
        res.status(500).json({ error: "Server error" });
    }
});

// ✅ Fetch All Students
router.get("/students", async (req, res) => {
    try {
        const students = await Student.find();
        res.json(students);
    } catch (error) {
        res.status(500).json({ error: "Server error" });
    }
});

// ✅ Fetch Single Student by Roll Number
router.get("/student/:rollNumber", async (req, res) => {
    try {
        const student = await Student.findOne({ rollNumber: req.params.rollNumber });

        if (!student) {
            return res.status(404).json({ error: "Student not found" });
        }

        res.json(student);
    } catch (error) {
        res.status(500).json({ error: "Server error" });
    }
});

module.exports = router; // ✅ Export Router
