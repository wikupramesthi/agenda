import { createContext, useContext, type ReactNode } from "react";
import { useApiData } from "./useApiData";
import { fetchWebsiteIdentity, type WebsiteIdentity } from "../data/websiteIdentity";

type WebsiteIdentityContextValue = {
  identity: WebsiteIdentity | null;
  loading: boolean;
  failed: boolean;
};

const WebsiteIdentityContext = createContext<WebsiteIdentityContextValue>({
  identity: null,
  loading: true,
  failed: false,
});

export function WebsiteIdentityProvider({ children }: { children: ReactNode }) {
  const { data, loading, failed } = useApiData(fetchWebsiteIdentity, [], "website-identity");
  return (
    <WebsiteIdentityContext.Provider value={{ identity: data, loading, failed }}>
      {children}
    </WebsiteIdentityContext.Provider>
  );
}

export function useWebsiteIdentity(): WebsiteIdentityContextValue {
  return useContext(WebsiteIdentityContext);
}
