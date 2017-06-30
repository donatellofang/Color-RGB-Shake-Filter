using UnityEngine;
using System.Collections;


    public class NormalFilterBehaviour : MonoBehaviour
    {

        public Material RenderMaterial;
        void OnRenderImage(RenderTexture s, RenderTexture d)
        {
            if (RenderMaterial != null)
            {
                RenderMaterial.SetVector("_ScreenResolution", new Vector4(s.width, s.height, 0.0f, 0.0f));
                Graphics.Blit(s, d, RenderMaterial);
            }
            else
            {
                Graphics.Blit(s, d);
            }
        }
    }


