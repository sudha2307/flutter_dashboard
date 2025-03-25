const mongoose = require("mongoose");

const StudentSchema = new mongoose.Schema({
    rollNumber: { type: String, required: true, unique: true },
    password: { type: String, required: true },  // Storing plain text (not recommended)
    name: { type: String, required: true },
    department: { type: String, required: true },
    age: { type: Number, required: true },
    year: { type: String, required: true },
    attendance: { type: Number, default: 100 },
}, { timestamps: true });

module.exports = mongoose.model("Student", StudentSchema);
