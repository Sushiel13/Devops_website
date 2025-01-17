/*
  # Create book files table

  1. New Tables
    - `book_files`
      - `id` (uuid, primary key)
      - `name` (text) - Original file name
      - `file_path` (text) - Storage path
      - `size` (bigint) - File size in bytes
      - `mime_type` (text) - File MIME type
      - `created_at` (timestamp)
      - `updated_at` (timestamp)

  2. Security
    - Enable RLS on `book_files` table
    - Add policies for authenticated users to read all files
    - Add policies for authenticated users to upload files
*/

CREATE TABLE IF NOT EXISTS book_files (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  file_path text NOT NULL,
  size bigint NOT NULL,
  mime_type text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE book_files ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can read book files"
  ON book_files
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Authenticated users can upload files"
  ON book_files
  FOR INSERT
  TO authenticated
  WITH CHECK (true);