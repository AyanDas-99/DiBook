const cloudinary = require('cloudinary').v2;
const uuid = require('uuid').v4;
const fs = require('fs');

class cloudinaryUtils {
    static async uploadFileToCloudinary(doc) {
        try {

            // Write PDFDocument to a temporary file:
            const tempFilePath = await new Promise((resolve, reject) => {
                const tempFile = fs.createWriteStream('/tmp/temporary-pdf.pdf');
                doc.pipe(tempFile).on('finish', () => resolve(tempFile.path));
            });

            // Upload using upload method:
            const uploadResult = await cloudinary.uploader.upload(tempFilePath, { resource_type: 'raw', public_id: `Dibook/Receipts/${uuid()}`});

            // Access the uploaded file URL:
            const uploadedFileUrl = uploadResult.secure_url;
            console.log("Uploaded file URL:", uploadedFileUrl);

            // Delete the temporary file:
            fs.unlinkSync(tempFilePath);

            return uploadedFileUrl;
        } catch (e) {
            console.error(e)
        }
    }
}

module.exports = cloudinaryUtils;