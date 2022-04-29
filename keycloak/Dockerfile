FROM quay.io/keycloak/keycloak:latest as builder

ENV KC_HEALTH_ENABLED=false
ENV KC_METRICS_ENABLED=false
ENV KC_FEATURES=web-authn
ENV KC_DB=postgres
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/
WORKDIR /opt/keycloak
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]
EXPOSE 8443