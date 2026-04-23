# Paper Documentation

## 1. Module Name
`Paper Documentation`

## 2. Responsibility
Holds the academic documentation (`paper/`) that formalizes the Vision-Language Geometric Programming approach for publication. This serves as the formal academic output and theoretical grounding for the VLM-LGP framework, including the manuscript, generated figures, and references.

## 3. Inputs
- System architecture logs and performance data
- VLM-LGP codebase execution results
- Draft manuscript texts
- Static and generated figures, diagrams, and plots

## 4. Outputs
- Compiled academic PDFs (e.g. `VLM_LGP_Assembly_demo_260302.pdf`)
- Final submission-ready LaTeX sources and configurations

## 5. Public Functions
- Presenting the VLM-LGP methodology to external reviewers and academic audiences.
- Serving as the definitive theoretical reference for the implemented robotic planning workflows.

## 6. Internal Functions
- Organizing LaTeX source files, bibliographies, and document styles.
- Managing version control of manuscript drafts and iterative improvements.

## 7. Dependencies
- LaTeX distribution (e.g., TeX Live) for compilation.
- Academic references and datasets.

## 8. Forbidden Dependencies
- Must not contain executable system code or configuration files that directly affect the `rai` solver or `LGP_TAMP` execution.

## 9. Failure Modes
- `Compilation Error`: LaTeX compilation fails due to missing packages or syntax errors.
- `Desynchronization`: The paper describes architectural components or workflows that no longer match the true behavior in `docs/` or `src/`.
