import { z } from 'zod';

export const signupSchema = z.object({
  name: z.string().min(2).max(100).trim(),
  email: z.email().min(5).max(255).lowercase().trim(),
  password: z.string().min(8).max(100),
  role: z.enum(['user', 'admin']).default('user'),
});

export const signinSchema = z.object({
  email: z.email().min(5).lowercase().trim(),
  password: z.string().min(8),
});
