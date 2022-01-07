using UnityEngine;

namespace ULib.Rendering.Components
{
    public class ShaderBlit : MonoBehaviour
    {
        public Shader shader = null;
        public RenderTexture renderTex = null;
        
        private Material internalMaterial = null;

        void OnEnable()
        {
            internalMaterial = new Material(shader);
        }

        private void OnDisable()
        {
            UnityEngine.Object.Destroy(internalMaterial);
        }

        void Update()
        {
            int passNo = internalMaterial.FindPass("ForwardOnly"); //For Shadergraphs
            if (passNo == -1)
            {
                passNo = 0;
            }

            Graphics.Blit(null, renderTex, internalMaterial, passNo);
        }
    }
}