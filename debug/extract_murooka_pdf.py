from pypdf import PdfReader
import re

p = "/Users/linxinxiang/Library/CloudStorage/OneDrive-UniversityofMacau/Publications/VLM-LGP/assets/literature/Murooka et al. - 2025 - Learning Differentiable Reachability Maps for Optimization-based Humanoid Motion Generation.pdf"
r = PdfReader(p)
t = "\n".join((pg.extract_text() or "") for pg in r.pages)

print("PAGES", len(r.pages))
for k in [
    "GMM",
    "Gaussian",
    "ESDF",
    "collision",
    "self-collision",
    "kinematic",
    "reachability map",
    "differentiable",
    "SDF",
    "signed distance",
    "mixture density network",
    "occupancy",
    "voxel",
    "grid",
]:
    print(k, len(re.findall(re.escape(k), t, re.I)))

for pat in [
    "mixture density network",
    "Gaussian mixture",
    "signed distance",
    "collision",
    "self-collision",
    "reachability map",
    "optimization-based motion generation",
    "latent",
]:
    m = re.search(pat, t, re.I)
    if m:
        print("\n===", pat, "===")
        a = max(0, m.start() - 220)
        b = min(len(t), m.start() + 680)
        print(t[a:b])

print("\n=== FIRST_1800 ===")
print(t[:1800])
