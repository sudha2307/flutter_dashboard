const express = require("express");
const Student = require("../models/student");
const router = express.Router();

// ✅ Register a Student (Add Details)
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
        res.status(500).json({ error: "Server error" });
    }
});

// ✅ Login Student (Check Credentials)
router.post("/login", async (req, res) => {
    const { rollNumber, password } = req.body;

    try {
        const student = await Student.findOne({ rollNumber });

        if (!student) {
            return res.status(400).json({ error: "User not found" });
        }

        if (student.password !== password) {
            return res.status(400).json({ error: "Invalid password" });
        }

        res.json({ message: "Login successful", student });
    } catch (error) {
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

module.exports = router;
